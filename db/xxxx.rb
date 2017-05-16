begin
    ActiveRecord::Base.transaction do
        # User.find_or_create_by(id: 1) do |user|
        #     user.id = 1,
        #     user.username = "テスト管理者",
        #     user.email = "choochoopiston@gmail.com",
        #     user.password = "password",
        #     user.password_confirmation = "password",
        #     user.employee_id = 2017000,
        #     user.admin = true
        # end
        # puts "ユーザID-1を登録しました。"
        # User.find_or_create_by(id: 2) do |user|
        #     user.id = 2,
        #     user.username = "原敬之",
        #     user.email = "takayukihara0805@gmail.com",
        #     user.password = "password",
        #     user.password_confirmation = "password",
        #     user.employee_id = 2017004
        # end
        # puts "ユーザID-2を登録しました。"
        BookDetail.find_or_initialize_by(id: 1) do |book_detail|
            if book_detail.new_record?
                book_detail.id = 1,
                book_detail.isbn_code = 9784839950644,
                book_detail.c_code = 3055,
                book_detail.title = "よくわかるPHPの許可書 PHP5.5対応版",
                book_detail.writer = "たにぐちまこと",
                book_detail.publisher = "マイナビ",
                book_detail.content = "ノンプログラマでも安心。最強の入門書!"
                book_detail.save!
            end
        end
        puts "書籍情報ID-1を登録しました。"
        BookDetail.find_or_create_by(id: 2) do |book_detail|
            # book_detail.id = 2,
            book_detail.isbn_code = 9784884337232,
            book_detail.c_code = 3055,
            book_detail.title = "Rails4技術者認定シルバー試験問題集",
            book_detail.writer = "株式会社システムシェアード 山田裕進",
            book_detail.publisher = "インプレス",
            book_detail.content = "注目のRuby on Rails資格、唯一の公式問題集登場!これ一冊で全てOK!模擬問題2回分付き!"
        end
        puts "書籍情報ID-2を登録しました。"
        # Book.find_or_create_by(id: 1) do |book|
        #     book.id = 1,
        #     book.code = "TEST0001",
        #     book.book_detail_id = 1,
        #     book.place = 0
        # end
        # puts "蔵書情報ID-1を登録しました。"
        # Book.find_or_create_by(id: 2) do |book|
        #     book.id = 2,
        #     book.code = "TEST0002",
        #     book.book_detail_id = 2,
        #     book.place = 0,
        #     book.state = 0
        # end
        # puts "蔵書情報ID-2を登録しました。"
        # Book.find_or_create_by(id: 3) do |book|
        #     book.id = 3,
        #     book.code = "TEST0003",
        #     book.book_detail_id = 2,
        #     book.place = 0
        # end
        # puts "蔵書情報ID-3を登録しました。"
    end
rescue => e
      puts "初期データ登録に失敗しました。#{e.message}"
      Rails.logger.error e.message
      Rails.logger.error e.backtrace.join("\n")  
end




