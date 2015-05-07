Template.entries_table.onRendered ->
    $('table').stickyTableHeaders
        fixedOffset: 0

Template.entries_table.helpers
    'results': ->
        results = ReactiveMethod.call 'getFieldValues', 'entry_page_name'
