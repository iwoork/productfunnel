Template.pos_table.onRendered ->
    $('table').stickyTableHeaders
        fixedOffset: 0

Template.pos_table.helpers
    'results': ->
        results = ReactiveMethod.call 'getFieldValues', 'user_context_name'
