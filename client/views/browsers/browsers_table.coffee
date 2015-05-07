Template.browsers_table.onRendered ->
    $('table').stickyTableHeaders
        fixedOffset: 0

Template.browsers_table.helpers
    'results': ->
        results = ReactiveMethod.call 'getFieldValues', 'brwsr_typ_name'
