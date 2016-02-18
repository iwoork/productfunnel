class @AnalysisController extends AppController 
    waitOn: ->
        [
            Meteor.subscribe 'funnels', {_id: @params._id}
        ]

    data: ->
        controller = @
        ready: -> controller.ready()
        property: ->
            Funnels.findOne(_id: controller.params._id)

    onBeforeAction: ->
        console.log "AnalysisController: onBeforeAction"
        @next()

    action: () ->
        console.log 'AnalysisController: action'
        @render()
