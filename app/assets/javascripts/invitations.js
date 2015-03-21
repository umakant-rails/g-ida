$(document).ready(function(){

  var add_in_poll_list = function(event, id){
    var poll_list = $("#invite_polls_list").val();
    if(poll_list == ''){
      poll_list = id;
    }else{
      poll_list = poll_list + "," + id;
    }
    $("#polls_list option[value='" + id + "']").remove();
    $("#invite_polls_list").val(poll_list);
    $("#polls_list_div").show()
  }

  var remove_from_poll_list = function(event, id){
    var poll_ques = $("#poll_"+id).text();
    var option_str = "<option value='" + id + "'>" + poll_ques + "</option>";
    var poll_list = $("#invite_polls_list").val();
    var poll_arr =  poll_list.split(',');
    var index = poll_arr.indexOf('1')
    poll_arr.splice(index, 1)
    $("#invite_polls_list").val(poll_arr.join(','));
    //$("#polls_list").append(option_str);
    var prev_val = -1;
    var options_arr = $("#polls_list option") ;
    for(var count = 0; count < options_arr.length; count++){
      var val = $(options_arr[count]).attr('value');
      if(id > val){
        prev_val = val;
      } else if(prev_val == -1){
        $("#polls_list option[value='" + val + "']").prev(option_str);
        break;
      } else {
        $("#polls_list option[value='" + prev_val + "']").after(option_str);
        break;
      }
    }

    if(poll_arr.length == 0){
      $("#polls_list_div").hide()
    }
  }

  $(document).on('change', '#polls_list', function(event){
    var poll = $(this).find('option:selected').text();
    var id = $(this).find('option:selected').val();
    var str = "<div class='poll_ques_list'>" +
      "<div class='poll_txt_div' id='poll_" + id + "'>" +  poll + "</div>" +
      "<div data-poll_id ='" + id + "' class='fa fa-times  poll_list_rm_icon'></div>" +
    "</div>";
     add_in_poll_list(event, id);
    $("#polls_list_div").append(str);
  });

  $(document).on('click', '.poll_list_rm_icon', function(event){
    var id = $(this).data('poll_id');
    remove_from_poll_list(event, id);
    $(this).parent().remove();
  });

  $(document).on('click', '.invited_for_chk_bx', function(event){
    var txt = $(this).val();
    if( txt == "all"){
      $("#polls_list").prop("disabled", true);
      $("#polls_list_div").children().remove();
      $("#polls_list_div").hide();

    } else {
      $("#polls_list").prop("disabled", false);
    }
  });

  $(document).on('click', '.invitation_emails_div', function(event){
    $(".invitation_emails_div.selected").removeClass('selected');
    var index = $(event.target).data('index');
    var invitation_id = $(event.target).data('invitation_id');

    $.ajax({
      url: "/invitations/" + invitation_id + "/invitations_polls",
      type: 'get',
      dataType: "script",
      success: function(data) {
        $(event.target).addClass('selected');
        var margin_top = 35 * index;
        $("#indicator_img").css('margin-top', margin_top + 'px');
      }

    });

  });

  $(document).on('click', '#invite_for_more_poll', function(event){
    var invitation_id = $(this).data('invitation_id');

  });

  $(document).on('change', '#invitation_emails', function(event){
    var invitation_email = $(event.target).val();
    if( invitation_email != ''){
      $.ajax({
        url: "/invitations/fetch_polls_to_invited_people",
        type: 'get',
        data: { email: invitation_email},
        dataType: "script",
        success: function(data) {
        }
      });
    }
  });

});


