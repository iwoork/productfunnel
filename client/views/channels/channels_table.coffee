Template.channels_table.onRendered ->
    $('table').stickyTableHeaders
        fixedOffset: 0

Template.channels_table.helpers
    'results': ->
        results = ReactiveMethod.call 'getFieldValues', 'mktg_sub_chnnl_name'
