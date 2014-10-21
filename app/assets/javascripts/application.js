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
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require bootstrap

$(window).scroll(function() {
   if($(window).scrollTop()  == -1) {
       //alert("bottom!");
       $('nav').toggleClass('test');
   }
});

//jQuery to collapse the navbar on scroll $(".navbar").offset().top > 50
$(window).scroll(function() {
    if ($(window).scrollTop()  == 0) {
        $('nav').removeClass('navbarBot');
        $('nav').addClass('navbarTop');
        $('.sidebarrules').removeClass('sidebarpos');
    } else {
        $('nav').addClass('navbarBot');
        $('nav').removeClass('navbarTop');
        $('.sidebarrules').addClass('sidebarpos');
    }
});

//jQuery for page scrolling feature - requires jQuery Easing plugin
$(function() {
    $('a.page-scroll').bind('click', function(event) {
        var $anchor = $(this);
        $('html, body').stop().animate({
            scrollTop: $($anchor.attr('href')).offset().top
        }, 1500, 'easeInOutExpo');
        event.preventDefault();
    });
});
