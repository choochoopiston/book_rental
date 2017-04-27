CSV.generate do |csv|
  csv_column_names = ["書籍ID", "蔵書ID", "蔵書コード", "配架場所", "貸出状況"]
  csv << csv_column_names
  @books.each do |book|
    csv_column_values = [
      book.book_detail_id,
      book.id,
      book.code, 
      book.place, 
      book.state
    ]
    csv << csv_column_values
  end
end