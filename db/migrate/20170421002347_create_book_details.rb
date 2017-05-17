class CreateBookDetails < ActiveRecord::Migration
  def change
    create_table :book_details do |t|
      # bigint型からstring型に変更
      t.bigint :isbn_code, null: false
      # c_codeいらないよな
      # int型からstring型に変更
      t.string :c_code
      t.string :title, null: false
      t.string :writer, null: false
      t.string :publisher
      # 追加したい
      t.date :published_date
      t.text :content

      t.timestamps null: false
    end
    #間違って同じCSVを一括登録にしないようにするため
    add_index :book_details, :title,                unique: true
  end
end
