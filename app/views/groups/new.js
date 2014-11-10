$("#modal").html("<%=escape_javascript(render :partial => 'groups/form', :locals => {group: @group})%>");
$(".modals").show();
$(".modals").fadeTo(200, 1.0);
