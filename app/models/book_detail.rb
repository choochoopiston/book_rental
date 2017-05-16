class BookDetail < ActiveRecord::Base
  has_many :books, inverse_of: :book_detail, :dependent => :destroy
  accepts_nested_attributes_for :books

  # validates :isbn_code, uniqueness: true, presence: true, format: { with: /\d{13}/ }
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
  
  def self.get_by_details(params1, params2, params3, params4)
    sql_body = ""
    if params1[:word].present?
      sql_body1 = "(#{params1[:column]} #{params1[:include]} '%#{params1[:word]}%')" 
      between1 =" #{params1[:andor]} "
    end
    
    if params2[:word].present?
      sql_body2 = "(#{params2[:column]} #{params2[:include]} '%#{params2[:word]}%')" 
      between2 =" #{params2[:andor]} "
    end
    
    if params3[:word].present?
      sql_body3 = "(#{params3[:column]} #{params3[:include]} '%#{params3[:word]}%')" 
      between3 =" #{params3[:andor]} "
    end
    
    if params4[:word].present?
      sql_body4 = "(#{params4[:column]} #{params4[:include]} '%#{params4[:word]}%')" 
      between4 =" #{params4[:andor]} "
    end
    
    #1
    if params1[:word].present? && params2[:word].blank? && params3[:word].blank? && params4[:word].blank?
      sql_body += sql_body1
    end
    
    #2
    if params1[:word].blank? && params2[:word].present? && params3[:word].blank? && params4[:word].blank?
      sql_body += sql_body2
    end
    
    #3
    if params1[:word].blank? && params2[:word].blank? && params3[:word].present? && params4[:word].blank?
      sql_body += sql_body3
    end
    
    #4
    if params1[:word].blank? && params2[:word].blank? && params3[:word].blank? && params4[:word].present?
      sql_body += sql_body4
    end
    
    #5
    if params1[:word].present? && params2[:word].present? && params3[:word].blank? && params4[:word].blank?
      sql_body += sql_body1 + between1 + sql_body2
    end
    
    #6
    if params1[:word].present? && params2[:word].blank? && params3[:word].present? && params4[:word].blank?
      sql_body += sql_body1 + between1 + sql_body3
    end
    
    #7
    if params1[:word].present? && params2[:word].blank? && params3[:word].blank? && params4[:word].present?
      sql_body += sql_body1 + between1 + sql_body4
    end
 
    #8
    if params1[:word].present? && params2[:word].present? && params3[:word].present? && params4[:word].blank?
      sql_body += sql_body1 + between1 + sql_body2 + between2 + sql_body3
    end
    
    #9
    if params1[:word].present? && params2[:word].present? && params3[:word].blank? && params4[:word].present?
      sql_body += sql_body1 + between1 + sql_body2 + between2 + sql_body4
    end
    
    #10
    if params1[:word].present? && params2[:word].blank? && params3[:word].present? && params4[:word].present?
      sql_body += sql_body1 + between1 + sql_body3 + between3 + sql_body4
    end
    
    #11
    if params1[:word].present? && params2[:word].present? && params3[:word].present? && params4[:word].present?
      sql_body += sql_body1 + between1 + sql_body2 + between2 + sql_body3 + between3 + sql_body4
    end
    
    #12
    if params1[:word].blank? && params2[:word].present? && params3[:word].present? && params4[:word].blank?
      sql_body += sql_body2 + between2 + sql_body3
    end
    
    #13
    if params1[:word].blank? && params2[:word].present? && params3[:word].blank? && params4[:word].present?
      sql_body += sql_body2 + between2 + sql_body4
    end
    
    #14
    if params1[:word].blank? && params2[:word].present? && params3[:word].present? && params4[:word].present?
      sql_body += sql_body2 + between2 + sql_body3 + between3 + sql_body4
    end
    
    #15
    if params1[:word].blank? && params2[:word].blank? && params3[:word].present? && params4[:word].present?
      sql_body += sql_body3 + between3 + sql_body4
    end
    

    
    if sql_body.present?
      sql = "select * from book_details where #{sql_body} order by id desc"
      details_ids = BookDetail.find_by_sql(sql)
      ids = []
      details_ids.each do |qi|
        ids.push(qi.id)
      end
      where(:id => ids)
    else
      where.not(id: nil)
    end
  end
  
  # CSV一括登録用
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      # IDが見つかれば、レコードを呼び出し、見つかれなければ、新しく作成
      # book_detail = find_by(id: row["id"]) || new
      book_detail = find_or_create_by(id: row["id"]) || new
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

