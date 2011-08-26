class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_locale

  def current_user
    session[:user] || nil
  end

  def set_locale
    I18n.locale = extract_locale_from_accept_language_header || "zh-cn"
  end

  def set_seo_meta(title,keywords = '',desc = '')
    if title
      @title = "#{title}"
      @title += "&raquo;#{t('title.logo')}"
    else
      @title = t('title.logo')
    end
    @meta_keywords = keywords
    @meta_description = desc
  end

  def login(user)
    if user.kind_of?(User)
      session[:user] = user
    else
      raise LoginError, "wrong user instance to login."
    end
  end

  def logout
    session[:user] = nil
  end

  private
  def extract_locale_from_accept_language_header
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}-[a-z]{2}/).first rescue nil
  end
end
