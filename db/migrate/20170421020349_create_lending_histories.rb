class CreateLendingHistories < ActiveRecord::Migration
  def change
    create_table :lending_histories do |t|
      t.references :book, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.datetime :return_date, null: false
      t.datetime :returned_date

      t.timestamps null: false
    end
  end
end
