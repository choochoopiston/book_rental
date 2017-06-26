# BookDetail.seed(:id) do |s|
#     s.id = 1
#     s.isbn_code = 9784839950644
#     s.c_code = "C3055"
#     s.title = "よくわかるPHPの許可書 PHP5.5対応版"
#     s.writer = "たにぐちまこと修正"
#     s.publisher = "マイナビ"
#     s.content = "ノンプログラマでも安心。最強の入門書!"
# end
# puts "書籍情報ID-1を登録しました。"
# BookDetail.seed(:id) do |s|
#     s.id = 2
#     s.isbn_code = 9784884337232
#     s.c_code = "C3055"
#     s.title = "Rails4技術者認定シルバー試験問題集２"
#     s.writer = "株式会社システムシェアード 山田裕進"
#     s.publisher = "インプレス"
#     s.content = "注目のRuby on Rails資格、唯一の公式問題集登場!これ一冊で全てOK!模擬問題2回分付き!"
# end
# puts "書籍情報ID-2を登録しました。"

require "csv"

begin
    ActiveRecord::Base.transaction do
        book_detail_csv = CSV.read('db/book_detail_seeds.csv', headers: true)
        book_detail_csv.each do |row|
            BookDetail.seed_once(:id) do |book_detail|
                book_detail.id = row[0]
                book_detail.isbn_code = row[1]
                book_detail.c_code = row[2]
                book_detail.title = row[3]
                book_detail.writer = row[4]
                book_detail.publisher = row[5]
                book_detail.published_date = row[6]
                book_detail.content = row[7]
                puts "書籍#{row[0]}登録!"
            end
        end
        book_csv = CSV.read('db/book_seeds.csv', headers: true)
        book_csv.each do |row|
            Book.seed_once(:id) do |book|
                book.id = row[0]
                book.code = row[1]
                book.book_detail_id = row[2]
                book.place = row[3]
                book.state = row[4]
                book.published_date = row[5]
                book.edition = row[6]
                puts "蔵書#{row[0]}登録!"
            end
        end
        User.find_or_initialize_by(employee_id: 2017000) do |user|
            user.username = "テスト管理者"
            user.username = "てすとかんりしゃ"
            user.email = "choochoopiston@gmail.com"
            user.password = "password"
            #初期データ投入したらすぐにパスワード変更すること。
            user.password_confirmation = "password"
            user.password_confirmation = "パスワード"
            user.employee_id = 2017000
            user.admin = true
            user.save!
            puts "ユーザID-1を登録しました。"
        end
        # User.find_or_initialize_by(employee_id: 2017004) do |user|
        #     user.username = "原敬之"
        #     user.email = "takayukihara0805@gmail.com"
        #     user.password = "password"
        #     user.password_confirmation = "password"
        #     user.employee_id = 2017004
        #     user.save!
        #     puts "ユーザID-2を登録しました。"
        # end
        # User.seed_once(:id) do |user|
        #     user.id = 1
        #     user.username = "テスト管理者"
        #     user.email = "choochoopiston@gmail.com"
        #     user.password = "password"
        #     user.password_confirmation = "password"
        #     user.employee_id = 2017000
        #     user.admin = true
        #     puts "ユーザID-1を登録しました。"
        # end
        # User.seed_once(:id) do |user|
        #     user.id = 2
        #     user.username = "原敬之"
        #     user.email = "takayukihara0805@gmail.com"
        #     user.password = "password"
        #     user.password_confirmation = "password"
        #     user.employee_id = 2017004
        #     puts "ユーザID-2を登録しました。"
        # end
    end
rescue => e
      puts "初期データ登録に失敗しました。#{e.message}"
      Rails.logger.error e.message
      Rails.logger.error e.backtrace.join("\n")  
end