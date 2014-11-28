# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#file upload
$(document).ready ->
  $('#fileupload').fileupload({
    dataType: 'json',
    done: (e, data) ->
			file = data.result
      console.log(
        data.textStatus,
        file.id,
        file.thumb
        file.photo_file_size
      ),
    fail: (e, data) ->
    	alert 'Upload failed'  
  })
