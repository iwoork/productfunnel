class @AppController extends RouteController 
    waitOn: ->

    onBeforeAction: ->
        console.log "AppController: onBeforeAction"
        @next()

    action: () ->
        console.log 'AppController: action'
        @render()
