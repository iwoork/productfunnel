class @AnalysisController extends AppController 
    waitOn: ->
        [
            Meteor.subscribe 'funnels'
        ]

    onBeforeAction: ->
        controller = @
        funnel = Funnels.findOne(_id: controller.params._id)
        Session.set 'funnel', funnel
        #_.each(funnel.filters, (filter) ->
        #    Meteor.call 'fields', filter.field, funnel.key, (err, result) ->
        #        console.log result
        #        Session.set 'filters_' + filter.field, result
        #)
        console.log "AnalysisController: onBeforeAction"
        @next()

    action: () ->
        console.log 'AnalysisController: action'
        @render()
