module BooksHelper
    
  def state_if(book_state)
    if book_state == 0
        "貸出可能○"
    elsif book_state == 1
        "貸出中×"
    else
        "持出厳禁×"
    end
  end
    
  def place_if(book_place)
    if book_place == 0
        "研修センター"
    else
        "本社"
    end
  end
  
end
