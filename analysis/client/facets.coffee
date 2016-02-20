Template.facets.helpers
    facets: ->
        funnel = Session.get 'funnel'
        funnel.filters
