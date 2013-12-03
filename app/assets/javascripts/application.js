// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery.rating
//= require jquery.rating.pack
//= require jquery.MetaData
//= require twitter/bootstrap
// require websocket_rails/main
// require_tree .

$(function(){
    $('.star-rating-control').attr('class', 'center-block');
    $('.alert-success').delay(1500).fadeOut('slow');
    var currentPage = location.pathname;
    currentPage = currentPage.split('?')[0];
    $('.nav > li').each(function(){
        var index = currentPage.indexOf($(this).children().attr('href'));
        if(index >= 0)
            $(this).attr('class', 'active');
    });
    //var dispatcher = new WebSocketRails('localhost:3000/websocket');

});

