jQuery ->
    # Delete an artifact
    $(document)
      .on "ajax:beforeSend", ".artifact", ->
        $(this).fadeTo('fast', 0.5)
      .on "ajax:success", ".artifact", ->
        $(this).hide('fast')
        count = $('#artifacts-count').text() 
        number = parseInt( count, 10 ) - 1;
        $('#artifacts-count').text(number) 
      .on "ajax:error", ".artifact", ->
        $(this).fadeTo('fast', 1)