CSV.generate do |csv|
  csv_column_names = ["book_detail_id", "code", "place", "state", "published_date", "edition"]
  csv << csv_column_names
end