source 'http://rubygems.org'

gem 'rails', '3.1.0.rc5'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'
# gem 'sqlite3'
gem 'mysql2'
# Asset template engines
gem 'sass-rails',"~> 3.1.0.rc"
gem 'coffee-script'
gem 'uglifier'

gem 'jquery-rails'
gem 'authlogic'
gem 'paperclip'
gem 'rmagick'
gem 'nokogiri', '~>1.5.0'
gem 'delayed_job'
gem 'kaminari'
gem 'uuid'
# Use unicorn as the web server
gem 'unicorn'

# Deploy with Capistrano
gem 'capistrano'

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
  gem 'sqlite3-ruby'
  gem 'factory_girl_rails'
end

group :development do
  # Pretty printed test output
  gem 'sqlite3-ruby'
  gem 'annotate', :git => 'git://github.com/jeremyolliver/annotate_models.git', :branch => 'rake_compatibility'
  # 性能分析插件
  gem 'rack-perftools_profiler', :require => 'rack/perftools_profiler'
  # To use debugger
  gem 'ruby-debug19', :require => 'ruby-debug'
end

group :production do
  #gem 'therubyracer'
end

# 搜索引擎采用
# thinking-sphinx + coreseek + mmseg
# http://www.coreseek.cn/
gem 'thinking-sphinx',
  :git     => 'git://github.com/freelancing-god/thinking-sphinx.git',
  :branch  => 'rails3'
gem 'ts-datetime-delta', '1.0.2',
  :require => 'thinking_sphinx/deltas/datetime_delta'
# 数据模型删除插件
gem 'paranoia'
#gem "omniauth",
#  :git => "git://github.com/intridea/omniauth.git"
gem "omniauth_china"

#Memcache
gem 'dalli'

#日志
gem 'syslogger'
