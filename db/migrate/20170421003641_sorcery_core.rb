class SorceryCore < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :crypted_password
      t.string :salt
      t.string :employee_id, null: false
      t.string :password_yomi, null: false
      t.string :username, null: false
      t.string :username_yomi, null: false
      
      t.boolean :admin, null: false, default: false
      
      t.timestamps                :null => false
    end

    add_index :users, :email, unique: true
    add_index :users, :employee_id, unique: true
  end
end
