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


    var isbnCode = $("#book_isbn").text();
    var googleUrl ="https://www.googleapis.com/books/v1/volumes?q=" + isbnCode;
    $.ajax({
      type: "GET",
      url: googleUrl,
      dataType: "json"
      }).done(function(json){
        //  console.log(json.items.length)
         var bookTitle = $("#book_title a").text().split(" ", 1)
         console.log(bookTitle[0])
         var apiTitle = json.items[0].volumeInfo.title.split(" ", 1)
         console.log(apiTitle)
         if(json.items.length >= 1 && apiTitle[0].match(bookTitle[0]) || bookTitle[0].match(apiTitle[0])  ) {
        //  if(json.items.length >= 1) {
            var thumb = json.items[0].volumeInfo.imageLinks.thumbnail;
            $("#book_img").empty();
            $("#book_img").prepend("<img src='" + thumb + "'/>");
            // for (var i=0; i<json.items.length; i++) {
            //     console.log(i);
            //     console.log(json.items[i].volumeInfo.readingModes);
            // }
         }

      });

});
