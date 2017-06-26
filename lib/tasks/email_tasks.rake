desc 'send check email'
task send_check_email: :environment do
    
    after_2days = Time.now + 2.day
    after_3days = Time.now + 3.day
    @three_days = LendingHistory.where(returned_date: nil).where("return_date > ? ", after_2days).where("return_date < ?", after_3days)
    UserMailer.three_to_deadline(@three_days).deliver
    # @three_days.each do |three_day|
    #   UserMailer.three_to_deadline(three_day).deliver
    # end
    
    @after_deadlines = LendingHistory.where(returned_date: nil).where("return_date < ? ", Time.now )
    UserMailer.need_to_return(@after_deadlines).deliver
    # @after_deadlines.each do |after_deadline|
    #   UserMailer.need_to_return(after_deadline).deliver
    # end
    
end