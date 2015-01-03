$("#modal").html("<%=escape_javascript(render :partial => 'problemsets/form', :locals => {problemset: @problemset})%>");
$(".modals").show();
$(".modals").fadeTo(200, 1.0);
$("#modal").css({
    'margin-top': function () { //vertical centering
        return -($(this).height() /2);
    },
    'margin-left': function () { //Horizontal centering
        return -($(this).width() /2);
    }
});
