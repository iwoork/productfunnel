class @DashboardController extends RouteController 
    waitOn: ->
        #channel_subscription = Meteor.subscribe 'dashboard_channel', {}
        #posa_subscription = Meteor.subscribe 'dashboard_posa', {}
        #return [
        #    channel_subscription
        #    posa_subscription
        #]

    data: ->
        self = @
        ready: () -> self.ready()

