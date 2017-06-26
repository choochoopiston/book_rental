class UserMailer < ApplicationMailer

    def lended_book(lh)
        @name = lh.user.username
        # @email = lh.user.email
        @book = lh.book
        @title = lh.book.book_detail.title
        @return_date = lh.return_date
        @lended_date = lh.created_at
        #TODO 本番アップ前に、ado-edu@ado-tech.co.jpに変更
        mail to: "choochoopiston@gmail.com", subject: "【株式会社アド・書籍レンタル】本がレンタルされました。"
    end
    
    def returned_book(lh)
        @name = lh.user.username
        # @email = lh.user.email
        @title = lh.book.book_detail.title
        @return_date = lh.return_date
        @returned_date = lh.returned_date
        @lended_date = lh.created_at
        @book = lh.book
        #TODO 本番アップ前に、ado-edu@ado-tech.co.jpに変更
        mail to: "choochoopiston@gmail.com", subject: "【株式会社アド・書籍レンタル】本が返却されました。"
    end

    def three_to_deadline(lh)
        # @name = lh.user.username
        # @email = lh.user.email
        # @book = lh.book
        # @title = lh.book.book_detail.title
        # @return_date = lh.return_date
        # @lended_date = lh.created_at
        # mail to: @email, subject: "【株式会社アド・書籍レンタル】返却期限がもうすぐです。"
        @lending_histories = lh
        #TODO 本番アップ前に、ado-edu@ado-tech.co.jpに変更
        mail to: "choochoopiston@gmail.com", subject: "【株式会社アド・書籍レンタル】返却期限が迫ってる人々。"
    end
    
    def need_to_return(lh)
        # @name = lh.user.username
        # @email = lh.user.email
        # @title = lh.book.book_detail.title
        # @return_date = lh.return_date
        # @lended_date = lh.created_at
        # @book = lh.book
        # mail to: @email, subject: "【株式会社アド・書籍レンタル】返却期限が過ぎてます。"
        @lending_histories = lh
        #TODO 本番アップ前に、ado-edu@ado-tech.co.jpに変更
        mail to: "choochoopiston@gmail.com", subject: "【株式会社アド・書籍レンタル】返却期限が過ぎている人々。"
    end
    
end
