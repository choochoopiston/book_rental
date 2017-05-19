class User < ActiveRecord::Base
  authenticates_with_sorcery!
  
  validates :email, uniqueness: true, presence: true
  validates :password, length: { minimum: 6, maximum: 8 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :employee_id, uniqueness: true, presence: true, format: { with: /\d{7}/ }
  validates :username, presence: true
  
  has_many :lending_histories, :dependent => :destroy
  
  # CSV一括登録用
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      # IDが見つかれば、レコードを呼び出し、見つかれなければ、新しく作成
      # user = find_by(id: row["id"]) || new
      user = new
      # CSVからデータを取得し、設定する
      user.attributes = row.to_hash.slice(*updatable_attributes)
      # 保存する
      user.save!
    end
  end
  
  # CSV一括登録用
  # 更新を許可するカラムを定義
  def self.updatable_attributes
    ["employee_id", "username", "email", "password", "password_confirmation", "admin"]
  end
  
end
