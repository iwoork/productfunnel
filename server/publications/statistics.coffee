calculateStatus = (filter) ->
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
                    month:
                        $month: "$local_date"
                    day:
                        $dayOfMonth: "$local_date"
                    year:
                        $year: "$local_date"
                visits:
                    $sum: "$home"
        }
        {
            $sort:
                '_id.month': 1
                '_id.day': 1
        }
    ]
    results = Visits.aggregate(pipeline)
    calculateMean(results)

Meteor.methods
    'getStatus': (filter) ->
        status = {}
        status.status = 'success'
        status.score = calculateStatus(filter)
        status
