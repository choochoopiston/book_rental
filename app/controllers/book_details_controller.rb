class BookDetailsController < ApplicationController
  skip_before_filter :require_login, only: [:index, :show]
  before_action :set_book_detail, only: [:show, :edit, :update, :destroy]
  before_action :check_admin, only: [:new, :create, :edit, :update, :destroy, :import]

  # GET /book_details
  # GET /book_details.json
  def index
    if params[:simplesearch].present? 
      @search_words = params[:simplesearch].split(/[ ,　]/)
      if params[:type_search] == "and_search"
        @book_details = BookDetail.get_by_multi_and_simplesearch(@search_words).includes(:books).order(:id)
      else
        @book_details = BookDetail.get_by_multi_or_simplesearch(@search_words).includes(:books).order(:id)
      end
    elsif params[:search1].present?
      @search_words = []
      @search_words.push(params[:search1][:word], params[:search2][:word], params[:search3][:word], params[:search4][:word])
      # @book_details = BookDetail.get_by_details(params[:search1], params[:search2], params[:search3], params[:search4]).page(params[:page])
      @book_details = BookDetail.get_by_details(params[:search1], params[:search2], params[:search3], params[:search4]).includes(:books).order(:id)
    else
      @search_words = []
      # @book_details = BookDetail.page(params[:page])
      @book_details = BookDetail.all.includes(:books).order(:id)
      

    end
    
    respond_to do |format|
      format.html do
        render :index
      end
      format.csv do
        send_data render_to_string, filename: "export_book_details.csv", type: :csv
      end
    end
    
  end

  # GET /book_details/1
  # GET /book_details/1.json
  def show
  end

  # GET /book_details/new
  def new
    @book_detail = BookDetail.new
    @book_detail.books.build unless params[:book_detail_only]
  end

  # GET /book_details/1/edit
  def edit
  end

  # POST /book_details
  # POST /book_details.json
  def create
    @book_detail = BookDetail.new(book_detail_params)

    respond_to do |format|
      if @book_detail.save
        format.html { redirect_to @book_detail, notice: '書籍情報が登録されました。' }
        format.json { render :show, status: :created, location: @book_detail }
      else
        format.html { render :new }
        format.json { render json: @book_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /book_details/1
  # PATCH/PUT /book_details/1.json
  def update
    respond_to do |format|
      if @book_detail.update(book_detail_params)
        format.html { redirect_to @book_detail, notice: '書籍情報が更新されました。' }
        format.json { render :show, status: :ok, location: @book_detail }
      else
        format.html { render :edit }
        format.json { render json: @book_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /book_details/1
  # DELETE /book_details/1.json
  def destroy
    @book_detail.destroy
    respond_to do |format|
      format.html { redirect_to book_details_url, notice: '書籍情報が削除されました。' }
      format.json { head :no_content }
    end
  end
  
  def import
    begin
      ActiveRecord::Base.transaction do
        # fileはtmpに自動で一時保存される
        BookDetail.import(params[:file])
      end
      redirect_to book_details_path, notice: "書籍情報を一括登録しました。"
    rescue => e
      redirect_to book_details_path, notice: "書籍情報を一括登録できませんでした。データに少しでも不備があると登録できません。#{e.message}"
      Rails.logger.error e.message
      Rails.logger.error e.backtrace.join("\n")  
    end
  end
  

  def download
    respond_to do |format|
      format.csv do
        send_data render_to_string, filename: "import_book_details_format.csv", type: :csv
      end
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book_detail
      @book_detail = BookDetail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    
    def book_detail_params
      params.require(:book_detail).permit(:isbn_code, :c_code, :title, :writer, :publisher, :content, :published_date, books_attributes: [:id, :code, :place, :state, :published_date, :edition])
    end
    
    def check_admin
      if current_user.admin == false
        redirect_to root_path, notice: "書籍情報の登録、編集、削除は、管理者しかできません。"
      end
    end
    
end
