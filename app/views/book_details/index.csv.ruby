# require 'csv'

CSV.generate do |csv|
  csv_column_names = ["書籍ID", "図書コード", "分類コード", "書籍名", "著者", "出版社", "初版発行日", "詳細"]
  csv << csv_column_names
  @book_details.each do |book_detail|
    csv_column_values = [
      book_detail.id,
      book_detail.isbn_code,
      book_detail.c_code,
      book_detail.title,
      book_detail.writer,
      book_detail.publisher,
      book_detail.published_date,
      book_detail.content
    ]
    csv << csv_column_values
  end
end