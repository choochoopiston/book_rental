class CreateBookDetails < ActiveRecord::Migration
  def change
    create_table :book_details do |t|
      t.bigint :isbn_code, null: false
      t.string :c_code
      t.string :title, null: false
      t.string :writer, default: nil
      t.string :publisher, default: nil
      t.date :published_date, default: nil
      t.text :content, default: nil

      t.timestamps null: false
    end
    add_index :book_details, :isbn_code,                unique: true
  end
end
