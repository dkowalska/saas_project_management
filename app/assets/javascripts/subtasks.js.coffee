jQuery ->
    $('.best_in_place').best_in_place()

    $('.best_in_place').click ->
      console.log "jdjdjdjdjd"
      $(this).removeClass "well well-sm well-light well-subtask mb-0"

    $('.best_in_place').bind 'ajax:success', ->
      $(this).addClass "well well-sm well-light well-subtask mb-0"

    # Create a subtask
    $(".subtask-form")
      .on "ajax:beforeSend", (evt, xhr, settings) ->
        $(this).find('textarea')
          .addClass('uneditable-input')
          .attr('disabled', 'disabled');
      .on "ajax:success", (evt, data, status, xhr) ->
        $(this).find('textarea')
          .removeClass('uneditable-input')
          .removeAttr('disabled', 'disabled')
          .val('');
        $(xhr.responseText).hide().insertAfter($(this)).show('fast')
        count = $('#subtask-count').text() 
        number = parseInt( count, 10 ) + 1;
        $('#subtask-count').text(number) 

    $(document).mouseup (e) ->
      container = $('.best_in_place')
      # if the target of the click isn't the container nor a descendant of the container
      if !container.is(e.target) and container.has(e.target).length == 0
        container.addClass "well well-sm well-light well-subtask mb-0"
      return

    # Delete a subtask
    $(document)
      .on "ajax:beforeSend", ".subtask-delete", ->
        $(this).closest(".subtask").fadeTo('fast', 0.5)
      .on "ajax:success", ".subtask-delete", ->
        $(this).closest(".subtask").hide('slow')
        count = $('#subtask-count').text() 
        number = parseInt( count, 10 ) - 1;
        $('#subtask-count').text(number) 
      .on "ajax:error", ".subtask-delete", ->
        $(this).closest(".subtask").fadeTo('fast', 1)