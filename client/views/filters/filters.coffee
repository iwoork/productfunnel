Template.filters.helpers
    'posa': Meteor.settings.public.posa
    'channels': ->
        ReactiveMethod.call 'getChannels'
    'platforms': Meteor.settings.public.platforms

Template.filters.getFilters = (filterSchema) ->
    filters = Session.get('filters') or {}
    Filters.compose(filters, filterSchema)

Template.filters.setFilters = (filters) ->
    Session.set('filters', filters)

Template.filters.performFilter = () ->
    # get checked filters

    # POSa
    posa = []
    @template.$('.filter-posa:checked').each (el) ->
        posa.push $(@).val()

    # channels
    channels = []
    @template.$('.filter-channel:checked').each (el) ->
        channels.push $(@).val()

    # platforms
    platforms = []
    @template.$('.filter-platform:checked').each (el) ->
        platforms.push $(@).val()

    filters = {
        posa: posa
        channels: channels
        platforms: platforms
    }
    Template.filters.setFilters(filters)


Template.filters.events
    'change .filter': (e, tmpl) ->
        Template.filters.performFilter.call({template : tmpl})

Template.filters.rendered = ->
    Filters.resetFacets()
    @$('.panel-heading:first a').click()
