class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.references :book_detail, index: true, foreign_key: true
      t.string :code, null: false
      t.integer :place, null: false, default: 0
      t.integer :state, null: false, default: 1
      t.date :published_date
      t.string :edition

      t.timestamps null: false
    end
    add_index :books, :code,                unique: true
  end
end
