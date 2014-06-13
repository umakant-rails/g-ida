$(document).ready(function(){
  /* custom tag it js start */
  $(document).on('focus, click', ".tagit_invite_user_ul", function(){
    $("#tagit_txt_input").focus();
  });

  var validate_email;
  validate_email = function(email) {
    var pattern = /^([a-zA-Z0-9_.-])+@([a-zA-Z0-9_.-])+\.([a-zA-Z])+([a-zA-Z])+/;
    var is_email_valid = false;
    if(email.match(pattern) != null){
      is_email_valid = true;
    }
    return is_email_valid;
  }

  var is_already_added = function(email){
    var counter = 0;
    $(".tagit_invite_user_ul li").each (function(index, element){
      var element_txt = $(element).text().trim();
      if(email == element_txt){
        counter += 1;
      }
    });
    return counter;
  }

  var email_add_remove_from_hidden_field = function(){
    var email_str =  '';
    $(".tagit_invite_user_ul li").each(function(){
      var email = $(this).text().trim();
      if(email != ''){
        if(email_str != ''){email_str += ",";}
        email_str += email;
      }
    });
    $("#invite_emails").val(email_str);
  }

  var make_tagit = function(self, action_fire_on, input_value, keycode){
    
    if( (action_fire_on != 'focusout') && (keycode != 13) ){
      var input_value = input_value.substr(0, input_value.length-1).trim();
    }
    var counter = is_already_added(input_value);
    if(validate_email(input_value) && ( counter == 0)){
      var li_string = '<li><span class="tagit-label">'+input_value+'</span><span class="text-icon icon-remove tagit-close"></span></li>';
      var ul_txt = $(".tagit_invite_user_ul").html();
      var last_li_index = ul_txt.lastIndexOf('<li>');
      var ul_txtt = ul_txt.substr(0,last_li_index)+li_string+ul_txt.substr(last_li_index,ul_txt.length); 
      $(".tagit_invite_user_ul").html(ul_txtt);
      $(self).val("");
      email_add_remove_from_hidden_field(); 
      $("#tagit_txt_input").focus();
      $("#error_msg").hide();
      $("#invite_peoples_for_poll").attr('disabled', false);
    }else{
      if(counter == 0){
        $("#error_msg").html(input_value + " is invalid email id").show();
      }else{
        var length = $(".tagit_invite_user_ul li").length
        //$(".tagit_invite_user_ul li")[length-2].remove();
        $("#error_msg").html(input_value + " is already exist").show();
      }
      if(action_fire_on == 'keyup'){
        input_value = input_value.substr(0, input_value.trim().length);
        $("#tagit_txt_input").val(input_value); 
      }
      $("#tagit_txt_input").focus();
     }
  }

  $(document).on('keyup', '#tagit_txt_input', function(event){
    var key_pressed = event.which;
    var input_value = $(this).val();
      if( (key_pressed == 32) || (key_pressed == 188) || (key_pressed == 13)){
      if(input_value.length > 1) {
        make_tagit(this, 'keyup', input_value, key_pressed);
      }
    }
    if(key_pressed == 13) {
      event.stopPropagation();
      return false;
    }
  });

  $(document).on('keypress', '#tagit_txt_input', function(event){
    var key_pressed = event.which;
    var input_value = $(this).val();
    if(key_pressed == 8){
      var total_li = $(".tagit_invite_user_ul li").length;
      if((total_li >= 2) && (input_value == '')){
        $(".tagit_invite_user_ul li")[total_li-2].remove();
        email_add_remove_from_hidden_field();
      }
    }
    if(key_pressed == 13) {
      event.stopPropagation();
      return false;
    }
  });
  
  $(document).on('focusout', '#tagit_txt_input', function(event){
    var input_value = $(this).val();
    if ( input_value.length > 1) {
      make_tagit(this, 'focusout', input_value);
    }
  });

  $(document).on('click', ".tagit-close", function(){
    $(this).parent().remove();
    email_add_remove_from_hidden_field();
    if( $(".tagit_invite_user_ul").find('li').length > 1){
      $("#invite_peoples_for_poll").attr('disabled', false); 
    } else if($(".tagit_invite_user_ul").find('li').length == 1){
      $("#invite_peoples_for_poll").attr('disabled', true);
      $("#error_msg").hide();
    }
  });

  $("#invites").submit(function(){
    var elements = $(".tagit_invite_user_ul li")
    var is_validate = true;
    for(var count = 0; count < elements.length-1; count++){
      var element = elements[count];
      var element_txt = $(element).text().trim();
      if(element_txt != ''){
        if(!validate_email(element_txt) || ( is_already_added(element_txt) > 1) ){
            is_validate = false;
        }
      }
    }
    return is_validate;
  });
});


