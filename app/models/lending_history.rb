class LendingHistory < ActiveRecord::Base
  belongs_to :book
  belongs_to :user
  
  def self.get_by_search(search_params)
    @lending_histories = LendingHistory.all
    if search_params[:word].present?
      @lending_histories = @lending_histories.joins({:book => :book_detail}).where("book_details.#{search_params[:column]} #{search_params[:include]} '%#{search_params[:word]}%'")
      if search_params[:start_year].present? && search_params[:end_year].present?
        start_time = DateTime.new(search_params[:start_year].to_i, search_params[:start_month].to_i)
        end_time = DateTime.new(search_params[:end_year].to_i, search_params[:end_month].to_i).end_of_month
        @lending_histories = @lending_histories.where("created_at between '#{start_time}' and '#{end_time}'")
      elsif search_params[:start_year].present? && search_params[:end_year].blank?
        from = DateTime.new(search_params[:start_year].to_i, search_params[:start_month].to_i)
        @lending_histories = @lending_histories.where("created_at >= ?", from)
      elsif search_params[:start_year].blank? && search_params[:end_year].present?
        to = DateTime.new(search_params[:end_year].to_i, search_params[:end_month].to_i).end_of_month
        @lending_histories = @lending_histories.where("created_at <= ?", to)
      else
      end
      if search_params[:returned] == "1" && search_params[:lended] != "1" && search_params[:delayed] != "1"
        @lending_histories = @lending_histories.where.not(returned_date: nil)
      elsif search_params[:returned] != "1" && search_params[:lended] == "1" && search_params[:delayed] != "1"
        @lending_histories = @lending_histories.where(returned_date: nil).where("return_date >= ?", Time.now)
      elsif search_params[:returned] != "1" && search_params[:lended] != "1" && search_params[:delayed] == "1"
        @lending_histories = @lending_histories.where(returned_date: nil).where("return_date < ?", Time.now)
      elsif search_params[:returned] == "1" && search_params[:lended] == "1" && search_params[:delayed] != "1"
        @lending_histories = @lending_histories.where("(returned_date != ?) OR (return_date >= ?)", nil, Time.now)
      elsif search_params[:returned] == "1" && search_params[:lended] != "1" && search_params[:delayed] == "1"
        @lending_histories = @lending_histories.where("(returned_date != ?) OR (return_date < ?)", nil, Time.now)
      elsif search_params[:returned] != "1" && search_params[:lended] == "1" && search_params[:delayed] == "1"
        @lending_histories = @lending_histories.where(returned_date: nil)
      else
      end
    else
      if search_params[:start_year].present? && search_params[:end_year].present?
        start_time = DateTime.new(search_params[:start_year].to_i, search_params[:start_month].to_i)
        end_time = DateTime.new(search_params[:end_year].to_i, search_params[:end_month].to_i).end_of_month
        @lending_histories = @lending_histories.where("created_at between '#{start_time}' and '#{end_time}'")
      elsif search_params[:start_year].present? && search_params[:end_year].blank?
        from = DateTime.new(search_params[:start_year].to_i, search_params[:start_month].to_i)
        @lending_histories = @lending_histories.where("created_at >= ?", from)
      elsif search_params[:start_year].blank? && search_params[:end_year].present?
        to = DateTime.new(search_params[:end_year].to_i, search_params[:end_month].to_i).end_of_month
        @lending_histories = @lending_histories.where("created_at <= ?", to)
      else
      end
      if search_params[:returned] == 1 && search_params[:lended] != 1 && search_params[:delayed] !=1
        @lending_histories = @lending_histories.where.not(returned_date: nil)
      elsif search_params[:returned] != 1 && search_params[:lended] == 1 && search_params[:delayed] !=1
        @lending_histories = @lending_histories.where(returned_date: nil).where("return_date >= ?", Time.now)
      elsif search_params[:returned] != 1 && search_params[:lended] != 1 && search_params[:delayed] ==1
        @lending_histories = @lending_histories.where(returned_date: nil).where("return_date < ?", Time.now)
      elsif search_params[:returned] == 1 && search_params[:lended] == 1 && search_params[:delayed] !=1
        @lending_histories = @lending_histories.where("(returned_date != ?) OR (return_date >= ?)", nil, Time.now)
      elsif search_params[:returned] == 1 && search_params[:lended] != 1 && search_params[:delayed] ==1
        @lending_histories = @lending_histories.where("(returned_date != ?) OR (return_date < ?)", nil, Time.now)
      elsif search_params[:returned] != 1 && search_params[:lended] == 1 && search_params[:delayed] ==1
        @lending_histories = @lending_histories.where(returned_date: nil)
      else
      end
    end
    @lending_histories
  end
  
  def lending_situation
    if returned_date != nil
      "返却済み"
    elsif return_date < Time.now
      "延滞中"
    else
      "貸出中"
    end
  end
  
end
