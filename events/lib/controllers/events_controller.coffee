class @EventsController extends AppController 
    waitOn: ->
        [
            Meteor.subscribe 'events'
        ]

    onBeforeAction: ->
        console.log "EventsController: onBeforeAction"
        @next()

    action: () ->
        console.log 'EventsController: action'
        @render()
