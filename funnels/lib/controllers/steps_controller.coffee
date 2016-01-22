class @StepsController extends AppController 
    waitOn: ->
        [
            Meteor.subscribe 'steps'
        ]

    onBeforeAction: ->
        console.log "StepsController: onBeforeAction"
        @next()

    action: () ->
        console.log 'StepsController: action'
        @render()
