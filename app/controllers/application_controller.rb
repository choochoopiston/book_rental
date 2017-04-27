class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_filter :require_login
  
  after_action  :store_location
  def store_location
    if (request.fullpath != "/login" &&
      request.fullpath != "/" &&
      request.fullpath != "/logout" &&
      request.fullpath != "/user_sessions" &&
        request.fullpath !~ Regexp.new("\\A/users/password.*\\z") &&
        !request.xhr?) # don't store ajax calls
      session[:previous_url] = request.fullpath 
    end
  end
  
  private
   
    def not_authenticated
      redirect_to login_path, alert: "Please login first"
    end
    
end
