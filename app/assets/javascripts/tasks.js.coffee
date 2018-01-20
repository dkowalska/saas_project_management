jQuery ->
    # Delete a task
    $(document)
      .on "ajax:beforeSend", ".task", ->
        $(this).fadeTo('fast', 0.5)
      .on "ajax:success", ".task", ->
        $(this).hide('fast')
        count = $('#tasks-count').text() 
        number = parseInt( count, 10 ) - 1;
        $('#tasks-count').text(number) 
      .on "ajax:error", ".task", ->
        $(this).fadeTo('fast', 1)