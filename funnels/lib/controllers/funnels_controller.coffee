class @FunnelsController extends AppController 
    waitOn: ->
        [
            Meteor.subscribe 'funnels'
        ]

    onBeforeAction: ->
        console.log "FunnelsController: onBeforeAction"
        @next()

    action: () ->
        console.log 'FunnelsController: action'
        @render()
