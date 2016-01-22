class @DimensionsController extends AppController 
    waitOn: ->
        [
            Meteor.subscribe 'dimensions'
        ]

    onBeforeAction: ->
        console.log "DimensionsController: onBeforeAction"
        @next()

    action: () ->
        console.log 'DimensionsController: action'
        @render()
