jQuery ->
    # Create a comment
    $(".client-comment-form")
      .on "ajax:beforeSend", (evt, xhr, settings) ->
        $(this).find('textarea')
          .addClass('uneditable-input')
          .attr('disabled', 'disabled');
      .on "ajax:success", (evt, data, status, xhr) ->
        $(this).find('textarea')
          .removeClass('uneditable-input')
          .removeAttr('disabled', 'disabled')
          .val('');
        $(xhr.responseText).hide().insertAfter($(this)).show('slow')
        count = $('#client-comm-count').text() 
        number = parseInt( count, 10 ) + 1;
        $('#client-comm-count').text(number) 

    # Create a comment
    $(".project-comment-form")
      .on "ajax:beforeSend", (evt, xhr, settings) ->
        $(this).find('textarea')
          .addClass('uneditable-input')
          .attr('disabled', 'disabled');
      .on "ajax:success", (evt, data, status, xhr) ->
        $(this).find('textarea')
          .removeClass('uneditable-input')
          .removeAttr('disabled', 'disabled')
          .val('');
        $(xhr.responseText).hide().insertAfter($(this)).show('slow')
        count = $('#project-comm-count').text() 
        number = parseInt( count, 10 ) + 1;
        $('#project-comm-count').text(number) 

    # Delete a client comment
    $(document)
      .on "ajax:beforeSend", ".client-comment", ->
        $(this).fadeTo('fast', 0.5)
      .on "ajax:success", ".client-comment", ->
        $(this).hide('fast')
        count = $('#client-comm-count').text() 
        number = parseInt( count, 10 ) - 1;
        $('#client-comm-count').text(number) 
      .on "ajax:error", ".client-comment", ->
        $(this).fadeTo('fast', 1)

    # Delete a project comment
    $(document)
      .on "ajax:beforeSend", ".project-comment", ->
        $(this).fadeTo('fast', 0.5)
      .on "ajax:success", ".project-comment", ->
        $(this).hide('fast')
        count = $('#project-comm-count').text() 
        number = parseInt( count, 10 ) - 1;
        $('#project-comm-count').text(number) 
      .on "ajax:error", ".project-comment", ->
        $(this).fadeTo('fast', 1)