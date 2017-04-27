class LendingHistory < ActiveRecord::Base
  belongs_to :book
  belongs_to :user
  
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
