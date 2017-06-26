$(function(){
    $('label[for=user_password]').append("<span class=\"small text-danger\">*必須</span>");
    $('label[for=user_password_confirmation]').append("<span class=\"small text-danger\">*必須</span>");
    $('label[for=user_employee_id]').append("<span class=\"small text-danger\">*必須</span>");
    $('label[for=user_username]').append("<span class=\"small text-danger\">*必須</span>");

    var API_KEY = ENV["GOOGLE_CUSTOM_SEARCH_API_KEY"];
    var CUSTOM_SEARCH_ENGINE = ENV["GOOGLE_CUSTOM_SEARCH_ENGINE_ID"];
    var word = $("#book_title a").text();
    console.log(word);
    var customUrl = "https://www.googleapis.com/customsearch/v1?key=" + API_KEY + "&cx=" + CUSTOM_SEARCH_ENGINE + "&q=" + word + "&searchType=image"
    $.ajax({
      type: "GET",
      url: customUrl,
      dataType: "json"
      }).done(function(json){
         console.log(json.items[0].link);
         console.log(json.items[0].image.contextLink);
         console.log(json.items[0].image.thumbnailLink);
      });
    
    
});