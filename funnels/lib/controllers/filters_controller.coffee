class @FiltersController extends AppController 
    waitOn: ->
        [
            Meteor.subscribe 'filters'
        ]

    onBeforeAction: ->
        console.log "FiltersController: onBeforeAction"
        @next()

    action: () ->
        console.log 'FiltersController: action'
        @render()
