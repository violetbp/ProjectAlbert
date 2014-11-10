$("#modal").html("<%=escape_javascript(render :partial => 'problemsets/form', :locals => {problemset: @problemset})%>");
$(".modals").show();
$(".modals").fadeTo(200, 1.0);
