class @VisitController extends RouteController 
    waitOn: ->
        currentYear = {
            local_date:
                $gte: new Date('2012-01-01')
                $lt: new Date('2014-12-31')
            entry_page_name: 'HOME PAGE'
        }
        [
            #Meteor.subscribe('visits',currentYear)
        ]

    data: ->
        self = @
