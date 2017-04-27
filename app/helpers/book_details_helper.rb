module BookDetailsHelper
  def state_if(book_state)
    if book_state == 0
        "持出厳禁×"
    elsif book_state == 1
        "貸出可能○"
    else
        "貸出中×"
    end
  end
    
  def place_if(book_place)
    if book_place == 0
        "研修センター"
    else
        "本社"
    end
  end
    
  def books_count(book_details)
    books = []
    book_details.each do |book_detail|
      books += book_detail.books
    end
    books.count
  end
  
end
