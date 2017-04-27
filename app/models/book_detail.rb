class BookDetail < ActiveRecord::Base
  has_many :books, inverse_of: :book_detail, :dependent => :destroy
  accepts_nested_attributes_for :books

  validates :isbn_code, uniqueness: true, presence: true, length: { is: 13 }
  validates :title, presence: true
  validates :writer, presence: true
  validates :publisher, presence: true
  
  scope :get_by_title, ->(title) {
    where("title ilike ?", "%#{title}%")
  }
  
  # scope :get_by_simplesearch, ->(simplesearch) {
  #   where("(title ilike ?) OR (writer ilike ?) OR (publisher ilike ?) OR (content ilike ?)", "%#{simplesearch}%", "%#{simplesearch}%", "%#{simplesearch}%", "%#{simplesearch}%")
  # }
  
  def self.get_by_multi_and_simplesearch(search_words)
    @book_details = BookDetail.all
    search_words.each do |search_word|
      @book_details = @book_details.where("(title ilike ?) OR (writer ilike ?) OR (publisher ilike ?) OR (content ilike ?)", "%#{search_word}%", "%#{search_word}%", "%#{search_word}%", "%#{search_word}%")
    end
    @book_details
  end
  
  def self.get_by_multi_or_simplesearch(search_words)
    sql_body = ''
    search_words.each do |search_word|
      sql_body += ' OR ' unless sql_body.blank?
      sql_body += "(title ilike '%#{search_word}%' OR writer ilike '%#{search_word}%' OR publisher ilike '%#{search_word}%' OR content ilike '%#{search_word}%')"
    end
    sql = "select * from book_details where #{sql_body} order by id desc"
    details_ids = BookDetail.find_by_sql(sql)
    ids = []
    details_ids.each do |qi|
      ids.push(qi.id)
    end
    where(:id => ids)
  end
  
  # CSV一括登録用
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      # IDが見つかれば、レコードを呼び出し、見つかれなければ、新しく作成
      book_detail = find_by(id: row["id"]) || new
      # CSVからデータを取得し、設定する
      book_detail.attributes = row.to_hash.slice(*updatable_attributes)
      # 保存する
      book_detail.save!
    end
  end
  
  # CSV一括登録用
  # 更新を許可するカラムを定義
  def self.updatable_attributes
    ["isbn_code", "c_code", "title", "writer", "publisher", "content"]
  end
  
  
end

