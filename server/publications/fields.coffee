Meteor.methods
    'getFieldValues': (field) ->
        self = @
        pipeline = [
            {
                $group:
                    _id: "$" + field
            }
            {
                $sort:
                    _id: 1
            }
        ]
        console.log pipeline
        results = Visits.aggregate(pipeline)
