$(document).on('turbolinks:load', function() {

  $('.answers').on('click', '.edit-answer-link', function(e) {
    e.preventDefault();
    $(this).hide();

    var answerId = $(this).data('answerId');

    $('form#edit-answer-' + answerId).show();
  });

  $('.answers').on('click', '.delete-answer-link', function(e) {
    e.preventDefault();
    $(this).hide();

    var answerId = $(this).data('answerId');

    $('#answer-id-' + answerId).remove();
  });

});
