Template.filter_option.helpers
    filters: ->
        name = Template.instance().data.filter
        filters = Session.get 'filters_' + name
        filters

Template.filter_option.onRendered =>
    name = Template.instance().data.name
 
