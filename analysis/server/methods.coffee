calculateContinuance = (step, filter) ->
    defaults = {}
    if step > 0
        prev = step - 1
    else
        prev = step
    console.log filter
    current = "$step" + step
    previous = "$step" + prev

    pipeline = [
        {
            $match:
                filter or defaults
        }
        {
            $group:
                _id:
                    local_date: "$local_date"
                count: 
                    $sum: current
                previous:
                    $sum: previous
        }
        {
            $project:
                local_date: "$_id.local_date"
                count: "$count"
                previous: "$previous"
                continuance:
                    $divide: [
                        "$count"
                        "$previous"
                    ]
        }
        {
            $sort:
                '_id.local_date': 1
        }
    ]
    console.log pipeline
    results = Analysis.aggregate(pipeline)

Meteor.methods
    'continuance': (step, filter) ->
        calculateContinuance(step, filter)

    'fields': (field, key) ->
        filters = Analysis.find({key: key}).fetch()
        results = _.uniq(filters, false, (d) ->
          d.field
        )
        available = {}
        available[field] = _.pluck(results, field)
        available
