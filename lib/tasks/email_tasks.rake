desc 'send check email'
task send_check_email: :environment do
    
    after_2days = Time.now + 2.day
    after_3days = Time.now + 3.day
    @three_days = LendingHistory.where(returned_date: nil).where("return_date > ? ", after_2days).where("return_date < ?", after_3days)
    @three_days.each do |three_day|
      @return_date = three_day.return_date
      @title = three_day.book.book_detail.title
      @email = three_day.user.email
      @name = three_day.user.username
      UserMailer.three_to_deadline(@email, @name).deliver!
    end
    
    @after_deadlines = LendingHistory.where(returned_date: nil).where("return_date < ? ", Time.now )
    @after_deadlines.each do |after_deadline|
      @return_date = after_deadline.return_date
      @title = after_deadline.book.book_detail.title
      @email = after_deadline.user.email
      @name = after_deadline.user.username
      UserMailer.need_to_return(@email, @name).deliver
    end
    
end