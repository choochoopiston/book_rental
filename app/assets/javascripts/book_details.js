$(function(){
    $('#narrow_button').bind("click",function(){
        // 書籍名&含むを選択
        if ($('#search_column').val() == "title" && $('#search_include').val() == "yes") {
            var re = new RegExp($('#search_word').val(), "i");
            $('tbody tr').each(function(){
                var txt = $(this).find("td:eq(2) a").html();
                if(txt.match(re) != null){
                    $(this).show();
                }else{
                    $(this).hide();
                }
            });
        }
        // 書籍名&含まないを選択
        if ($('#search_column').val() == "title" && $('#search_include').val() == "no") {
            var re = new RegExp($('#search_word').val(), "i");
            $('tbody tr').each(function(){
                var txt = $(this).find("td:eq(2) a").html();
                if(txt.match(re) != null){
                    $(this).hide();
                }else{
                    $(this).show();
                }
            });
        }
        // 著者&含むを選択
        if ($('#search_column').val() == "writer" && $('#search_include').val() == "yes") {
            var re = new RegExp($('#search_word').val(), "i");
            $('tbody tr').each(function(){
                var txt = $(this).find("td:eq(3)").html();
                if(txt.match(re) != null){
                    $(this).show();
                }else{
                    $(this).hide();
                }
            });
        }
        // 著者&含まないを選択
        if ($('#search_column').val() == "writer" && $('#search_include').val() == "no") {
            var re = new RegExp($('#search_word').val(), "i");
            $('tbody tr').each(function(){
                var txt = $(this).find("td:eq(3)").html();
                if(txt.match(re) != null){
                    $(this).hide();
                }else{
                    $(this).show();
                }
            });
        }
        // 出版社&含むを選択
        if ($('#search_column').val() == "publisher" && $('#search_include').val() == "yes") {
            var re = new RegExp($('#search_word').val(), "i");
            $('tbody tr').each(function(){
                var txt = $(this).find("td:eq(4)").html();
                if(txt.match(re) != null){
                    $(this).show();
                }else{
                    $(this).hide();
                }
            });
        }
        // 出版社&含まないを選択
        if ($('#search_column').val() == "publisher" && $('#search_include').val() == "no") {
            var re = new RegExp($('#search_word').val(), "i");
            $('tbody tr').each(function(){
                var txt = $(this).find("td:eq(4)").html();
                if(txt.match(re) != null){
                    $(this).hide();
                }else{
                    $(this).show();
                }
            });
        }
    });
    $('#narrow_cancel_button').bind("click",function(){
        $('tr').show();
    });
    
// フォームID [isbn] に入力があった場合、jQueryの関数 [change] を使ってISBNコードを取得。
// Google Books APIへ問い合わせを行う。
// もしGoogle Books APIに書籍が存在しない(totalItemsが0の場合)、入力欄に表示されたデータをすべて消去し、該当書籍がないとメッセージを表示する

    $("#isbn_api").click(function() {
      const isbn = $("#book_detail_isbn_code").val();
      const url = "https://www.googleapis.com/books/v1/volumes?q=isbn:" + isbn;

      $.getJSON(url, function(data) {
        if(!data.totalItems) {
          $("#book_detail_isbn_code").val("");
          $("#book_detail_c_code").val("");
          $("#book_detail_title").val("");
          $("#book_detail_writer").val("");
          $("#book_detail_publisher").val("");
          $("#book_detail_content").text("");

          $("#message").html('<p class="bg-warning" id="warning">該当する書籍がありません。</p>');
          $('#message > p').fadeOut(3000);

        } else {

// 該当書籍が存在した場合、JSONから値を取得して入力項目のデータを取得する
          $("#book_detail_isbn_code").val(data.items[0].volumeInfo.industryIdentifiers[0].identifier);
          $("#book_detail_title").val(data.items[0].volumeInfo.title);
          $("#book_detail_writer").val(data.items[0].volumeInfo.authors[0]);
          $("#book_detail_publisher").val(data.items[0].volumeInfo.publisher);
          $("#book_detail_content").val(data.items[0].volumeInfo.description);
        }

      });
    });
    
    $('input[name="lendable"]').change(function() {
        var val = $('#lendable:checked').val();
        console.log(val)
        var re = "貸出可能○"
        if (val == 1) {
            $('tbody tr').each(function(){
                var txt = $(this).find("td:eq(0)").html();
                if(txt.match(re) != null){
                    $(this).show();
    
                }else{
                    $(this).hide();          
                }
            });
        } else {
            $('tr').show();
        }
    });
});