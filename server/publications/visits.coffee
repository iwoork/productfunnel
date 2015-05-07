Meteor.methods
    'getVisits': (filter) ->
        self = @
        console.log filter
        defaults = {
            local_date:
                $gte: new Date('2012-01-01')
                $lt: new Date('2014-12-31')
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
                        entry_page_name: "$entry_page_name"
                        day:
                            $dayOfYear: "$local_date"
                        dayOfWeek:
                            $dayOfWeek: "$local_date"
                    visits:
                        $sum: "$home"
            }
            {
                $sort:
                    '_id.entry_page_name': 1
            }
        ]
        results = Visits.aggregate(pipeline)
        _.each(results, (row) ->
            self.added 'visits', Random.id(), row
        )
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
        #row.day = row._id.day
        #row.year = row._id.year
        #row.month = row._id.month
        #row.entry_page_name = row._id.entry_page_name
        #row.dayOfWeek = row._id.dayOfWeek
        self.added 'visits', Random.id(), row
    )
    @ready()
