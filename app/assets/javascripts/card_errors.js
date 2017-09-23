$(function(){
  $("#new_card").on('ajax:success', function(e, data, status, xhr) {
    remove_errors();
    add_errors(data);
  });

  $(".edit_card").on('ajax:success', function(e, data, status, xhr) {
    remove_errors();
    add_errors(data);
  });

  remove_errors = function(){
    $('.has-error').removeClass('has-error');
    $('.has-feedback').removeClass('has-feedback');
    $('.help-block').remove();
    $('.form-control-feedback').remove();
  };

  add_errors = function(data){
    var model_name = Object.keys(data)[0];
    var errors = data[model_name];

    for (var i in errors){
      el = $('#' + model_name + '_' + i);  
      el.closest('.form-group').addClass('has-error');
      for (m = errors[i].length - 1; m >= 0; m-- ){
        el.after('<small class="help-block">' + errors[i][m] + '</small>');
      };
    };    
  };
});
