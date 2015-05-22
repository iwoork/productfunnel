Meteor.methods
    'getVisits': (funnel, filter, group) ->
        defaults = {
            local_date:
                $gte: new Date('2015-01-01')
                $lt: new Date('2015-01-31')
        }
        pipeline = [
            {
                $match:
                    filter or defaults
            }
            {
                $group:
                    _id:
                        group
                    home:
                        $sum: "$home"
                    search:
                        $sum: "$search"
                    pdp:
                        $sum: "$pdp"
                    bf:
                        $sum: "$bf"
                    conf:
                        $sum: "$conf"
            }
        ]
        results = Visits.aggregate(pipeline)
        response= {}
        visits = []
        conversions = []
        dows = []
        _.each(results, (record) ->
            # Let's fire it up
            visit = []
            conversion = []
            dow = []
            console.log record
            date = Date.parse(record._id.year + '-' + record._id.month + '-' + record._id.day)
            console.log date
            funnel_data = record[funnel]

            # Visits
            visit.push date
            visit.push funnel_data
            visits.push visit

            # Conversions
            conversion.push date
            if record.conf > 0 and funnel_data > 0
                conversion.push (record.conf/funnel_data)
            else
                conversion.push 0
            conversions.push conversion

            # DoW data
            dow.push date
            dow.push 1
            dows.push dow
        )
        response.visits = visits
        response.conversions = conversions
        response.dows = dows
        response

Meteor.publish 'visits', (filter, group) ->
    self = @
    #console.log filter
    defaults = {
        local_date:
            $gte: new Date('2012-01-01')
            $lt: new Date('2014-12-31')
    }
    pipeline = [
        {
            $match:
                filter or defaults
        }
        {
            $group:
                _id:
                    group
                home:
                    $sum: "$home"
                search:
                    $sum: "$search"
                pdp:
                    $sum: "$pdp"
                bf:
                    $sum: "$bf"
                conf:
                    $sum: "$conf"
        }
    ]
    results = Visits.aggregate(pipeline)
    _.each(results, (row) ->
        _.each(row._id, (unique, index) ->
            row[index] = unique
        )
        self.added 'visits', Random.id(), row
    )
    @ready()
