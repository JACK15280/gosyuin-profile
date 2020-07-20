$(function(){
  function buildHTML(comment){
    var html = `<div class="container__comments">
                  <p>
                    <a class="container__comments--name" href=/users/${comment.user_id}>${comment.user_name}</a>
                    ：
                  ${comment.text}
                  </p>
                </div>`
    return html;
  }
  $('#new_comment').on('submit', function(e){
    e.preventDefault();
    var formData = new FormData(this);
    var url = $(this).attr('action')
    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data){
      var html = buildHTML(data);
      $('.container').append(html);
      $('.container__text').val('');
      $('.container__btn').prop('disabled', false);
    })
    .fail(function(){
      alert('コメントが送信出来ませんでした');
    })
  })
});