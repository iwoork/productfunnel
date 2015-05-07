class @HomepageController extends RouteController 
    waitOn: ->

    data: ->
        self = @
        ready: () -> self.ready()

