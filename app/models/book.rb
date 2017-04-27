class Book < ActiveRecord::Base
  belongs_to :book_detail
  has_many :lending_histories, :dependent => :destroy
    
  validates :book_detail, presence: true
  validates :code, uniqueness: true, presence: true

  # CSV一括登録用
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      # IDが見つかれば、レコードを呼び出し、見つかれなければ、新しく作成
      book = find_by(id: row["id"]) || new
      # CSVからデータを取得し、設定する
      book.attributes = row.to_hash.slice(*updatable_attributes)
      # 保存する
      book.save!
    end
  end
  
  # CSV一括登録用
  # 更新を許可するカラムを定義
  def self.updatable_attributes
    ["book_detail_id", "code", "place", "state"]
  end

end
