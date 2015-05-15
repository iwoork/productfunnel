Template.platforms_table.onRendered ->
    $('table').stickyTableHeaders
        fixedOffset: 0

Template.platforms_table.helpers
    'results': ->
        results = ReactiveMethod.call 'getFieldValues', 'c302'
