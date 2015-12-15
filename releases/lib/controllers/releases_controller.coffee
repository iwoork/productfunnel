class @ReleasesController extends RouteController 
    waitOn: ->
        [
            Meteor.subscribe 'releases'
        ]

    onBeforeAction: ->
        console.log "ReleasesController: onBeforeAction"
        @next()
