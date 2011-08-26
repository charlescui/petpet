default_run_options[:pty] = true

set :application, "petpet-project"
set :repository,  "git@github.com:charlescui/petpet.git"
set :scm, :git
set :scm_username, "zheng.cuizh@gmail.com"
set :branch, "master"
set :keep_releases, 3   # 留下多少个版本的源代码

set :user,      "cuizheng"   # 服务器 SSH 用户名
set :password,  "cuizheng"  # 服务器 SSH 密码
set :deploy_to, "/home/#{user}/Desktop/#{application}"
set :use_sudo,  false

role :web, "localhost"                          # Your HTTP server, Apache/etc
role :app, "localhost"                          # This may be the same as your `Web` server
role :db,  "localhost", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  desc "Init symble link local file system to shared file system."
  task :symble => :environment, :roles => :app do
    SYMLINKS.each { |key,path|
      if Dir.exist?(Petpet::Application.config.petpet[:nfs][key])
        ftype = File.ftype(Petpet::Application.config.petpet[:nfs][key])
        if ftype == "directory" || ftype == "link"
          # donothing
        else
          raise RuntimeError, "#{Petpet::Application.config.petpet[:nfs][key]} exist,but not a directory or link."
        end
      else
        FileUtils.mkdir_p(Petpet::Application.config.petpet[:nfs][key])
      end

      # 删除本地链接
      # 再新建链接
      FileUtils.rm Petpet::Application.config.petpet[:lfs][key], :force => true
      FileUtils.ln_sf(Petpet::Application.config.petpet[:nfs][key], Petpet::Application.config.petpet[:lfs][key])
    }
  end

  desc "Restart unicorn"
  task :restart, :roles => :app do
    run "kill -USR2 `cat #{current_path}/tmp/pids/unicorn.pid`"
  end

  desc "Start unicorn"
  task :start, :roles => :app do
    run "cd #{current_path} && unicorn_rails -c #{current_path}/config/unicorn.rb -E #{rails_env} -D"
  end

  desc "Stop unicorn"
  task :stop, :roles => :app do
    run "kill -QUIT `cat #{current_path}/tmp/pids/unicorn.pid`"
  end
end
