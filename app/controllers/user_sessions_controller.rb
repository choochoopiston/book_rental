class UserSessionsController < ApplicationController
  skip_before_filter :require_login, except: [:destroy]
  
  def new
    @user = User.new
  end
 
  def create
    if @user = login(params[:employee_id], params[:password])
      redirect_to session[:previous_url] || user_path(current_user), notice: "ログインしました。"
    else
      flash.now[:alert] = 'ログイン失敗。'
      redirect_to root_path, notice: "社員番号もしくはパスワードが間違っています。"
    end
  end
 
  def destroy
    logout
    redirect_to root_path, notice: 'ログアウトしました。'
  end
end
