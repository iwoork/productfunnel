Meteor.publish 'dashboard_channel', (filter) ->
    self = @
    _.each Meteor.settings.public.channels, (channel) ->
        pipeline = [
           {
                $group:
                    _id: channel.shortcode
                    visits:
                        $sum: 1
            }
        ]
        results = Visits.aggregate(pipeline)

        _.each(results, (row) ->
            self.added 'dashboard_channel', channel.shortcode, row
        )
    @ready()

Meteor.publish 'dashboard_posa', (filter) ->
    self = @
    _.each Meteor.settings.public.posa, (posa) ->
        pipeline = [
            {
                $match:
                    pos: posa.shortcode
                    date:
                        $gte: ISODate(new Date('2014-01-19T04:00:00Z'))
                        $lt: ISODate(new Date('2014-10-20T04:00:00Z'))
            }
            {
                $group:
                    _id: posa.shortcode
                    visits:
                        $sum: 1
            }
        ]
        results = Visits.aggregate(pipeline)
        _.each(results, (row) ->
            self.added 'dashboard_posa', row._id, row
        )
    @ready()

Meteor.methods
    fetchData: (options)->
        self = @
        console.log options
        pipeline = [
            {
                $match:
                    pos: options.pos
                    date:
                        '$gte': new Date(options.date_from.toISOString())
                        '$lt': new Date(options.date_to.toISOString())
            }
            {
                $group:
                    _id: options.pos
                    visits:
                        $sum: "$visits"
                    orders:
                        $sum: "$visits"
                    cvr:
                        $sum: "$visits"
            }
        ]
        console.log pipeline[0]
        Visits.aggregate(pipeline)
