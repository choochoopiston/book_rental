json.extract! user, :id, :email, :crypted_password, :salt, :employee_id, :username, :admin, :created_at, :updated_at
json.url user_url(user, format: :json)
