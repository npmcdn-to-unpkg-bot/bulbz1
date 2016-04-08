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
//= require bootstrap-sprockets
//= require turbolinks
//= require_tree .


$(function() {

    $("#menu-toggle").click(function(e) {
        e.preventDefault();
        $("#wrapper").toggleClass("toggled");
    });


  $('#menu_ein').click(function(e) {
    e.preventDefault();
    $('#menu_aus').show();
    $("#sidebar-wrapper").animate( { width: "330px"}, 100,
      function() {
        $('#wrapper').css('padding-left', '330px');
      });

  });

    $('#menu_aus').click(function(e) {
    e.preventDefault();
    $(this).hide();
    $('#menu_aus').show();
    $("#sidebar-wrapper").animate( { width: "0px"}, 100,
      function() {
        $('#wrapper').css('padding-left', '0px');
      });

  });



});


