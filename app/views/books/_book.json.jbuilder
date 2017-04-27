json.extract! book, :id, :book_detail_id, :code, :place, :state, :created_at, :updated_at
json.url book_url(book, format: :json)
