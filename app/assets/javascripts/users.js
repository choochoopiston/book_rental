$(function(){
    $('label[for=user_email]').append("<span class=\"small text-danger\">*必須</span>");
    $('label[for=user_password]').append("<span class=\"small text-danger\">*必須</span>");
    $('label[for=user_password_confirmation]').append("<span class=\"small text-danger\">*必須</span>");
    $('label[for=user_employee_id]').append("<span class=\"small text-danger\">*必須</span>");
    $('label[for=user_username]').append("<span class=\"small text-danger\">*必須</span>");
});