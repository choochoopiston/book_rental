begin
    ActiveRecord::Base.transaction do
        BookDetail.find_or_initialize_by(id: 1) do |book_detail|
            book_detail.c_code = "C3055"
            book_detail.isbn_code = 9784839950644
            book_detail.title = "よくわかるPHPの許可書 PHP5.5対応版"
            book_detail.writer = "たにぐちまこと"
            book_detail.publisher = "マイナビ"
            book_detail.content = "ノンプログラマでも安心。最強の入門書!"
            book_detail.save!
            puts "書籍情報ID-1を登録しました。"
        end
        BookDetail.find_or_initialize_by(id: 2) do |book_detail|
            book_detail.c_code = "C3055"
            book_detail.isbn_code = 9784884337232
            book_detail.title = "Rails4技術者認定シルバー試験問題集2"
            book_detail.writer = "株式会社システムシェアード 山田裕進"
            book_detail.publisher = "インプレス"
            book_detail.content = "注目のRuby on Rails資格、唯一の公式問題集登場!これ一冊で全てOK!模擬問題2回分付き!"
            book_detail.save!
            puts "書籍情報ID-2を登録しました。"
        end
        User.find_or_initialize_by(id: 1) do |user|
            user.username = "テスト管理者"
            user.email = "choochoopiston@gmail.com"
            user.password = "password"
            user.password_confirmation = "password"
            user.employee_id = 2017000
            user.admin = true
            user.save!
            puts "ユーザID-1を登録しました。"
        end
        User.find_or_initialize_by(id: 2) do |user|
            user.username = "原敬之"
            user.email = "takayukihara0805@gmail.com"
            user.password = "password"
            user.password_confirmation = "password"
            user.employee_id = 2017004
            user.save!
            puts "ユーザID-2を登録しました。"
        end
        Book.find_or_initialize_by(id: 1) do |book|
            book.code = "TEST0001"
            book.book_detail_id = 1
            book.place = 0
            book.save!
            puts "蔵書情報ID-1を登録しました。"
        end
        Book.find_or_initialize_by(id: 2) do |book|
            book.code = "TEST0002"
            book.book_detail_id = 2
            book.place = 0
            book.state = 0
            book.save!
            puts "蔵書情報ID-2を登録しました。"
        end
        Book.find_or_initialize_by(id: 3) do |book|
            book.code = "TEST0003"
            book.book_detail_id = 2
            book.place = 0
            book.save!
            puts "蔵書情報ID-3を登録しました。"        
        end
    end
rescue => e
      puts "初期データ登録に失敗しました。#{e.message}"
      Rails.logger.error e.message
      Rails.logger.error e.backtrace.join("\n")  
end



