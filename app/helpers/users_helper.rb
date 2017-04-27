module UsersHelper
  def admin_if(user_admin)
    if user_admin == true
        "管理者"
    else
        "一般ユーザ"
    end
  end
end
