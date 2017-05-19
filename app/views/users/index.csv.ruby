CSV.generate do |csv|
  csv_column_names = ["ユーザID", "社員番号", "ユーザ名", "メアド", "パスワード", "管理者権限"]
  csv << csv_column_names
  @users.each do |user|
    csv_column_values = [
      user.id,
      user.employee_id,
      user.username,
      user.email,
      user.crypted_password,
      user.admin
    ]
    csv << csv_column_values
  end
end