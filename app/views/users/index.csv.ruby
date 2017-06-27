CSV.generate do |csv|
  csv_column_names = ["ユーザID", "社員番号", "ユーザ名", "ユーザ名読み", "所属", "メアド", "パスワード", "パスワード読み","管理者権限"]
  csv << csv_column_names
  @users.each do |user|
    csv_column_values = [
      user.id,
      user.employee_id,
      user.username,
      user.username_yomi,
      user.belonging,
      user.email,
      user.crypted_password,
      user.password_yomi,
      user.admin
    ]
    csv << csv_column_values
  end
end