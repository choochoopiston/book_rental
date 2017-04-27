CSV.generate do |csv|
  csv_column_names = ["isbn_code", "c_code", "title", "writer", "publisher", "content"]
  csv << csv_column_names
end