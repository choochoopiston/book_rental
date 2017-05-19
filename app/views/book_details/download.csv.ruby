CSV.generate do |csv|
  csv_column_names = ["isbn_code", "c_code", "title", "writer", "publisher", "published_date", "content"]
  csv << csv_column_names
end