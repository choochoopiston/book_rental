json.extract! book_detail, :id, :isbn_code, :c_code, :title, :writer, :publisher, :content, :created_at, :updated_at
json.url book_detail_url(book_detail, format: :json)
