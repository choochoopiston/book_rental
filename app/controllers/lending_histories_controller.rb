class LendingHistoriesController < ApplicationController
  skip_before_filter :require_login, only: [:send_email, :send_warning]
  before_action :set_lending_history, only: [:update]
  # before_action :check_mine, only: [:update]
  before_action :check_mine_or_admin, only: [:update]
  before_action :check_admin, only: [:index]
  
  def index
    if params[:search].present? 
      @lending_histories = LendingHistory.get_by_search(params[:search]).page(params[:page])
    else
      @lending_histories = LendingHistory.page(params[:page])
    end
  end
  
  def update
    if params[:history] == "return"
      begin
        ActiveRecord::Base.transaction do
          @lending_history.returned_date = Time.now
          @lending_history.book.state = 0
          @lending_history.save!
          @lending_history.book.save!
        end
        UserMailer.returned_book(@lending_history).deliver
        redirect_to @lending_history.book, notice: '本を返却しました。'
      rescue => e
        redirect_to @lending_history.book, notice: '本を返却できませんでした。'
        Rails.logger.error e.message
        Rails.logger.error e.backtrace.join("\n")  
      end
    elsif @lending_history.return_date - @lending_history.created_at < 60.days && 60.days - (@lending_history.return_date - @lending_history.created_at) >= 14.days
      @lending_history.return_date += 14.days
      @lending_history.save
      redirect_to @lending_history.book, notice: '返却期限が延長されました。'
    elsif @lending_history.return_date - @lending_history.created_at < 60.days
      @lending_history.return_date = @lending_history.created_at + 60.days
      @lending_history.save
      redirect_to @lending_history.book, notice: '返却期限が延長されました。'
    else
      redirect_to @lending_history.book, notice: '返却期限はもう延長できません。'
    end
  end
  
  def send_email
    @after_deadlines = LendingHistory.where(returned_date: nil).where("return_date < ? ", Time.now )
    @after_deadlines.each do |after_deadline|
      # @return_date = after_deadline.return_date
      # @title = after_deadline.book.book_detail.title
      # @email = after_deadline.user.email
      # @name = after_deadline.user.username
      # UserMailer.need_to_return(@email, @name).deliver
      UserMailer.need_to_return(after_deadline).deliver
    end
    redirect_to root_path
  end
  
  def send_warning
    after_2days = Time.now + 2.day
    after_3days = Time.now + 3.day
    @three_days = LendingHistory.where(returned_date: nil).where("return_date > ? ", after_2days).where("return_date < ?", after_3days)
    @three_days.each do |three_day|
      # @return_date = three_day.return_date
      # @title = three_day.book.book_detail.title
      # @email = three_day.user.email
      # @name = three_day.user.username
      # UserMailer.three_to_deadline(@email, @name).deliver
      UserMailer.three_to_deadline(three_day).deliver
    end
    redirect_to root_path
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lending_history
      @lending_history = LendingHistory.find(params[:id])
    end
    
    def check_mine
      if @lending_history.user != current_user
        redirect_to root_path, notice: "借りた本人のみしか返却・延長できません。"
      end
    end
    
    def check_admin
      if current_user.admin != true
        redirect_to root_path, notice: "管理者のみ閲覧可です。"
      end
    end
    
    def check_mine_or_admin
      unless @lending_history.user == current_user || current_user.admin == true
        redirect_to root_path, notice: "借りた本人のみしか返却・延長できません（管理者以外）。"
      end
    end
      
end
