Meteor.methods
    'getVisits': (filter) ->
        self = @
        console.log filter
        defaults = {
            local_date:
                $gte: new Date('2015-01-01')
                $lt: new Date('2015-01-31')
            entry_page_name: 'HOME PAGE'
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
        @ready()

Meteor.publish 'visits', (filter, group) ->
    self = @
    console.log filter
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
