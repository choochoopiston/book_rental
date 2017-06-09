# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170421020349) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "book_details", force: :cascade do |t|
    t.integer  "isbn_code",      limit: 8, null: false
    t.string   "c_code"
    t.string   "title",                    null: false
    t.string   "writer"
    t.string   "publisher"
    t.date     "published_date"
    t.text     "content"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "book_details", ["isbn_code"], name: "index_book_details_on_isbn_code", unique: true, using: :btree

  create_table "books", force: :cascade do |t|
    t.integer  "book_detail_id"
    t.string   "code",                       null: false
    t.integer  "place",          default: 0, null: false
    t.integer  "state",          default: 0, null: false
    t.date     "published_date"
    t.string   "edition"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "books", ["book_detail_id"], name: "index_books_on_book_detail_id", using: :btree
  add_index "books", ["code"], name: "index_books_on_code", unique: true, using: :btree

  create_table "lending_histories", force: :cascade do |t|
    t.integer  "book_id"
    t.integer  "user_id"
    t.datetime "return_date",   null: false
    t.datetime "returned_date"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "lending_histories", ["book_id"], name: "index_lending_histories_on_book_id", using: :btree
  add_index "lending_histories", ["user_id"], name: "index_lending_histories_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                                           null: false
    t.string   "crypted_password"
    t.string   "salt"
    t.string   "employee_id",                                     null: false
    t.string   "username",                                        null: false
    t.boolean  "admin",                           default: false, null: false
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["employee_id"], name: "index_users_on_employee_id", unique: true, using: :btree
  add_index "users", ["remember_me_token"], name: "index_users_on_remember_me_token", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", using: :btree

  add_foreign_key "books", "book_details"
  add_foreign_key "lending_histories", "books"
  add_foreign_key "lending_histories", "users"
end
