class ProvidersController < ApplicationController
  def failure
    redirect_to "/404.html"
  end
  
  def delete
    if current_user
      @provider = Provider.find(params[:id])
      if @provider.user == current_user
        begin
          @provider.destroy
          render :json => {:status => 0, :msg => "delete provider ok"}
        rescue => ex
          render :json => {:status => -1, :msg => "delete provider fail"}
        end
      else
        render :json => {:status => -2, :msg => "forbidden."}
      end
    end
  end

  def auth
    session["omniauth.auth"] = request.env["omniauth.auth"]
    render :layout => false
  end

  def create
    set_seo_meta(t('title.provider'))
    omniauth = session["omniauth.auth"]
    @provider = Provider.auth(omniauth)

    if current_user
      # 如果已登录用户访问oauth
      # 并且验证成功
      # 则认为该用户更改绑定关系
      # 一个provider只属于一个用户
      # 不允许多个新浪微博帐号和多个用户绑定
      # TODO
      # => 将绑定关系的更改与新建独立
      Provider.transaction do
        @provider = Provider.build_from_omniauth(omniauth) unless @provider
        current_user.providers << @provider
      end
      redirect_to edit_user_path(current_user)
    elsif @provider
      if @provider.user
        @user = @provider.user
        login_in(@user)
        redirect_to user_path(@user)
      else
        # 数据库存储记录时,事件发生问题
        redirect_to login_path, :notice => t("user_session.create_from_provider.record_error")
      end
    else
      begin
        Provider.transaction do
          @provider = Provider.build_from_omniauth(omniauth)
          @user = User.build_from_omniauth(omniauth)
          @user.save!
          @user.providers << @provider
        end
        render "edit.html.erb"
      rescue => ex
        redirect_to login_path, :notice => t("user_session.create_from_provider.transaction_error")
      end
    end
  end

end
