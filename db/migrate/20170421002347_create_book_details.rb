class CreateBookDetails < ActiveRecord::Migration
  def change
    create_table :book_details do |t|
      t.bigint :isbn_code, null: false
      # c_codeいらないよな
      t.integer :c_code
      t.string :title, null: false
      t.string :writer, null: false
      t.string :publisher
      # 追加したい
      # t.date :published_date
      t.text :content

      t.timestamps null: false
    end
  end
end
