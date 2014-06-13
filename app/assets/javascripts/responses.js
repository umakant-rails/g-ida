// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).on('click', ".accordion-toggle", function(){
  var div_id = $(this).data('id');
  $(div_id).toggleClass('collapse'); 
});
