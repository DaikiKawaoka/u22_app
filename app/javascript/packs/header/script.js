'use strict';

//ログインフォームjs
$(function() {
  $("#login-show").click(function(){
    $('#login-modal').fadeIn(0.1);
  });
  $('#close-modal').click(function() {
    $('#login-modal').fadeOut(0.1);
  });
});

$(document).ready(function(){
  var formInputs = $('input[type="text"],input[type="password"]');
  formInputs.focus(function() {
     $(this).parent().children('.formLabel').addClass('formTop');
  });
  formInputs.focusout(function() {
      if ($.trim($(this).val()).length == 0){
      $(this).parent().children('.formLabel').removeClass('formTop');
      }
  });
  $('.formLabel').click(function(){
       $(this).parent().children('.form-control').focus();
  });
});
