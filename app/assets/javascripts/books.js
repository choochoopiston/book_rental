$(function(){
    $('label[for=book_book_detail_id]').append("<span class=\"small text-danger\">*必須</span>");
    $('label[for=book_code]').append("<span class=\"small text-danger\">*必須</span>");
    $('label[for=book_place]').append("<span class=\"small text-danger\">*必須</span>");
    $('label[for=book_state]').append("<span class=\"small text-danger\">*必須</span>");
    
    $('label[for=book_detail_isbn_code]').append("<span class=\"small text-danger\">*必須</span>");
    $('label[for=book_detail_c_code]').append("<span class=\"small text-danger\">*必須</span>");
    $('label[for=book_detail_title]').append("<span class=\"small text-danger\">*必須</span>");
    $('label[for=book_detail_writer]').append("<span class=\"small text-danger\">*必須</span>");
    $('label[for=book_detail_publisher]').append("<span class=\"small text-danger\">*必須</span>");
    
    $('label[for=book_detail_books_attributes_0_code]').append("<span class=\"small text-danger\">*必須</span>");

});
