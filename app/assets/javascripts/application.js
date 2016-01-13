// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require twitter/bootstrap
//= require_tree .

function add_fields(link, association, content){

	var new_id = new Date().getTime();
	var regexp = new RegExp("new_"+association, "g");
	c = content.replace(regexp, new_id);
	$(link).before(c);	
}

function remove_fields(link){	
	$(link).prev().val(1);
	$(link).parent().parent().hide();
	// console.log($(link).parent('form-group'))
	// console.log($(link).prev().val());
}