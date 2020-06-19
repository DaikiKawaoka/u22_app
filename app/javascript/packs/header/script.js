'use strict';

//ログインフォームjs
$(function() {
  $("#login-show").click(function(){
    $('#login-modal').fadeIn();
  });
  $('#close-modal').click(function() {
    $('#login-modal').fadeOut();
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

//絞り込みjs
$(function() {
  $('.side-menu').hover(
      function(){
        $(this).stop(true).animate({'margin-left':'200px' }, 400);
        $('.container').stop(true).animate({'margin-left':'200px' }, 400);
      },
      function () {
        $(this).animate({'margin-left':'0px'}, 500);
        $('.container').animate({'margin-left':'0px'}, 500);
      }
 );
});
