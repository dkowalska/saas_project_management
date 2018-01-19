jQuery ->
    # Delete a task
    $(document)
      .on "ajax:beforeSend", ".task", ->
        $(this).fadeTo('fast', 0.5)
      .on "ajax:success", ".task", ->
        $(this).hide('fast')
      .on "ajax:error", ".task", ->
        $(this).fadeTo('fast', 1)