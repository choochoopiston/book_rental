class UserMailer < ApplicationMailer

    def lended_book(lh)
        @name = lh.user.username
        @email = lh.user.email
        @book = lh.book
        @title = lh.book.book_detail.title
        @return_date = lh.return_date
        @lended_date = lh.created_at
        mail to: "choochoopiston@gmail.com", subject: "【株式会社アド・書籍レンタル】本がレンタルされました。"
    end
    
    def returned_book(lh)
        @name = lh.user.username
        @email = lh.user.email
        @title = lh.book.book_detail.title
        @return_date = lh.return_date
        @lended_date = lh.created_at
        @book = lh.book
        mail to: "choochoopiston@gmail.com", subject: "【株式会社アド・書籍レンタル】本が変革されました。"
    end

    def three_to_deadline(lh)
        @name = lh.user.username
        @email = lh.user.email
        @book = lh.book
        @title = lh.book.book_detail.title
        @return_date = lh.return_date
        @lended_date = lh.created_at
        mail to: @email, subject: "【株式会社アド・書籍レンタル】返却期限がもうすぐです。"
    end
    
    def need_to_return(lh)
        @name = lh.user.username
        @email = lh.user.email
        @title = lh.book.book_detail.title
        @return_date = lh.return_date
        @lended_date = lh.created_at
        @book = lh.book
        mail to: @email, subject: "【株式会社アド・書籍レンタル】返却期限が過ぎてます。"
    end
    
end
