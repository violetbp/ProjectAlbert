// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require jquery.remotipart
//= require jquery.iframe-transport
//= require_tree .
//= require bootstrap
//= require jquery-ui
//= require alerts
//require turbolinks


/*
$(window).scroll(function() {	
   if($(window).scrollTop()  == -1) {
       //alert("top!");
       $('nav').toggleClass('test');
   }
});*/


//jQuery for page scrolling feature - requires jQuery Easing plugin
$(function() {
    $('.scrolll').bind('click', function(event) {
        var $anchor = $(this);
        $('body').stop().animate({
            scrollTop: $($anchor.attr('href')).offset().top }, 1500, 'easeInOutExpo');
        event.preventDefault();
      return false;
    });
    
});

$(function() {
    $( "#accordion" ).accordion();
});


$(function() {
    $( "#accordion-collapse" ).accordion({
      //want this but can't have it: collapsible: true
      heightStyle: "content"
    });
});


//single collapse
$(function() {
  $('.collapse').click(function(){
    $('.content-one').slideToggle('slow');
  });
});

//problemsets
$(function() {
    $( document ).tooltip({
      position: {
        my: "center bottom-20",
        at: "center top",
        using: function( position, feedback ) {
          $( this ).css( position );
          $( "<div>" )
            .addClass( "arrow" )
            .addClass( feedback.vertical )
            .addClass( feedback.horizontal )
            .appendTo( this );
        }
      }
    });
  });