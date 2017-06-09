require "csv"

begin
    ActiveRecord::Base.transaction do
        book_detail_csv = CSV.read('db/book_detail_seeds.csv', headers: true)
        book_detail_csv.each do |row|
            BookDetail.find_or_initialize_by(id: row[0]) do |book_detail|
                book_detail.isbn_code = row[1]
                book_detail.c_code = row[2]
                book_detail.title = row[3]
                book_detail.writer = row[4]
                book_detail.publisher = row[5]
                book_detail.published_date = row[6]
                book_detail.content = row[7]
                book_detail.save!
                puts "書籍#{row[0]}登録!"
            end
        end
        book_csv = CSV.read('db/book_seeds.csv', headers: true)
        book_csv.each do |row|
            Book.find_or_initialize_by(id: row[0]) do |book|
                book.code = row[1]
                book.book_detail_id = row[2]
                book.place = row[3]
                book.state = row[4]
                book.published_date = row[5]
                book.edition = row[6]
                book.save!
                puts "蔵書#{row[0]}登録!"
            end
        end
        User.create(username: "テスト管理者",
                    email: "choochoopiston@gmail.com",
                    password: "password",
                    password_confirmation: "password",
                    employee_id: 2017000,
                    admin: true
        )
        User.create(username: "原敬之",
                    email: "takayukihara0805@gmail.com",
                    password: "password",
                    password_confirmation: "password",
                    employee_id: 2017004,

        )
        # User.find_or_initialize_by(id: 1) do |user|
        #     user.username = "テスト管理者"
        #     user.email = "choochoopiston@gmail.com"
        #     user.password = "password"
        #     user.password_confirmation = "password"
        #     user.employee_id = 2017000
        #     user.admin = true
        #     user.save!
        #     puts "ユーザID-1を登録しました。"
        # end
        # User.find_or_initialize_by(id: 2) do |user|
        #     user.username = "原敬之"
        #     user.email = "takayukihara0805@gmail.com"
        #     user.password = "password"
        #     user.password_confirmation = "password"
        #     user.employee_id = 2017004
        #     user.save!
        #     puts "ユーザID-2を登録しました。"
        # end
    end
rescue => e
      puts "初期データ登録に失敗しました。#{e.message}"
      Rails.logger.error e.message
      Rails.logger.error e.backtrace.join("\n")  
end



