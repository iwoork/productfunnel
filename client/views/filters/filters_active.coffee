Template.filters_active.helpers
    'posa': ->
        filters = Session.get 'filters'
        #filters['posa']
    'channel': ->
        filters = Session.get 'filters'
        #filters['channels']
    'platform': ->
        filters = Session.get 'filters'
        #filters['platform']
