CSV.generate do |csv|
  csv_column_names = ["蔵書ID", "蔵書コード", "書籍ID", "配架場所", "貸出状況", "発行日", "発行版"]
  csv << csv_column_names
  @books.each do |book|
    csv_column_values = [
      book.id,
      book.code, 
      book.book_detail_id,
      book.place, 
      book.state,
      book.published_date,
      book.edition
    ]
    csv << csv_column_values
  end
end