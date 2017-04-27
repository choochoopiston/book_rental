CSV.generate do |csv|
  csv_column_names = ["book_detail_id", "code", "place", "state"]
  csv << csv_column_names
end