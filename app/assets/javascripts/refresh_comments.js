$(document).ready(function(){
	if ($('#comment_update').length){
		var interval = setInterval(refreshPartial, 3000);
		$(document).on("turbolinks:load", function(){
			clearTimeout(interval);
		});
	}
});


function refreshPartial() {
  $.ajax({
    url: $('#comment_update').data("project-path"),
    type: 'get',
    success: function(resp) {
eval(resp)
    }
 })
}