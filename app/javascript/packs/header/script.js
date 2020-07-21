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
$(function() {
  // $('input[type=file]').after('<span></span>');

  // アップロードするファイルを選択
  $('input[type=file]').change(function() {
    var file = $(this).prop('files')[0];

    // 画像以外は処理を停止
    if (! file.type.match('image.*')) {
      // クリア
      $(this).val('');
      $('span').html('');
      return;
    }

    // 画像表示
    var reader = new FileReader();
    reader.onload = function() {
      var img_src = $('<img>').attr('src', reader.result);
      $('#image').html(img_src);
    }
    reader.readAsDataURL(file);
  });
});
// flash フェードアウト
$(function(){
  setTimeout("$('.flash').fadeOut('slow')", 2000);
});