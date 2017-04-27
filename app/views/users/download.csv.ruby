CSV.generate do |csv|
  csv_column_names = ["employee_id", "username", "email", "password", "password_confirmation", "admin"]
  csv << csv_column_names
end