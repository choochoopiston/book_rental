CSV.generate do |csv|
  csv_column_names = ["ユーザID", "社員番号", "メアド", "ユーザ名", "パスワード", "管理者権限"]
  csv << csv_column_names
  @users.each do |user|
    csv_column_values = [
      user.id,
      user.employee_id,
      user.email,
      user.username,
      user.crypted_password,
      user.admin
    ]
    csv << csv_column_values
  end
end