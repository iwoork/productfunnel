class @AnalysisController extends AppController 
    waitOn: ->
        [
            Meteor.subscribe 'funnels'
            Meteor.subscribe 'filters'
        ]

    onBeforeAction: ->
        controller = @
        funnel = Funnels.findOne(_id: controller.params._id)
        Session.set 'funnel', funnel
        console.log "AnalysisController: onBeforeAction"
        @next()

    action: () ->
        console.log 'AnalysisController: action'
        @render()
