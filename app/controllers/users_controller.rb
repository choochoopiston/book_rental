class UsersController < ApplicationController
  # skip_before_filter :require_login, only: [:new, :create]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :check_mine_or_admin, only: [:show]
  before_action :check_admin, only: [:new, :create, :index, :edit, :update, :destroy, :import]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
    
    respond_to do |format|
      format.html do
        render :index
      end
      format.csv do
        send_data render_to_string, filename: "export_users.csv", type: :csv
      end
    end
    
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'ユーザを登録しました。' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'ユーザ情報が更新されました。' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'ユーザを削除しました。' }
      format.json { head :no_content }
    end
  end
  
  def import
    begin
      ActiveRecord::Base.transaction do
        # fileはtmpに自動で一時保存される
        User.import(params[:file])
      end
      redirect_to users_path, notice: "ユーザ情報を一括登録しました。"
    rescue => e
      redirect_to users_path, notice: "ユーザ情報を一括登録できませんでした。データに少しでも不備があると登録できません。#{e.message}"
      Rails.logger.error e.message
      Rails.logger.error e.backtrace.join("\n")  
    end
  end
  
  def download
    respond_to do |format|
      format.csv do
        send_data render_to_string, filename: "import_users_format.csv", type: :csv
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :employee_id, :username, :admin)
    end
    
    def check_admin
      if current_user.admin == false
        redirect_to root_path, notice: "ユーザの登録、編集、削除は、管理者しかできません。"
      end
    end
    
    def check_mine_or_admin
      unless @user == current_user || current_user.admin == true
        redirect_to root_path, notice: "他人のユーザページは見れません（管理者以外）。"
      end
    end
    
end
