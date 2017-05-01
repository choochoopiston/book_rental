class BooksController < ApplicationController
  skip_before_filter :require_login, only: [:index, :show]
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :check_admin, only: [:new, :create, :edit, :destroy, :import]

  # GET /books
  # GET /books.json
  def index
    @books = Book.all
    
    respond_to do |format|
      format.html do
        render :index
      end
      format.csv do
        send_data render_to_string, filename: "export_books.csv", type: :csv
      end
    end
    
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  # GET /books/new
  def new
    if params[:book_detail]
      book_detail = BookDetail.find(params[:book_detail])
      @book = book_detail.books.build
    else
      @book = Book.new
    end
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: '蔵書情報が登録されました。' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    if params[:history] == "lend"
      @book.state = 2
      @lending_history = @book.lending_histories.build
      @lending_history.user = current_user
      @lending_history.return_date = Time.now + 14.days
      @book.save
      UserMailer.lended_book(@lending_history).deliver
      redirect_to @book, notice: '本を借りました。'
    # elsif params[:history] == "return"
    #   @book.state = 1
    #   lending_histories = @book.lending_histories.where(user_id: current_user.id).where(returned_date: nil)
    #   lending_histories[0].returned_date = Time.now
    #   @book.lending_histories << lending_histories[0]
    #   @book.save
    #   redirect_to @book, notice: 'Book was returned.'
    else
      respond_to do |format|
        if @book.update(book_params)
          format.html { redirect_to @book, notice: '蔵書情報が更新されました。' }
          format.json { render :show, status: :ok, location: @book }
        else
          format.html { render :edit }
          format.json { render json: @book.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: '蔵書情報が削除されました。' }
      format.json { head :no_content }
    end
  end
  
  def import
    begin
      ActiveRecord::Base.transaction do
        # fileはtmpに自動で一時保存される
        Book.import(params[:file])
      end
        redirect_to books_path, notice: "蔵書情報を一括登録しました。"
      rescue => e
      redirect_to books_path, notice: "蔵書情報を一括登録できませんでした。データに少しでも不備があると登録できません。#{e.message}"
      Rails.logger.error e.message
      Rails.logger.error e.backtrace.join("\n")  
    end
  end
  
  def download
    respond_to do |format|
      format.csv do
        send_data render_to_string, filename: "import_books_format.csv", type: :csv
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:book_detail_id, :code, :place, :state)
    end
    
    def check_admin
      if current_user.admin == false
        redirect_to root_path, notice: "蔵書情報の登録、編集、削除は、管理者しかできません。"
      end
    end
    
end
