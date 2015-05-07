Meteor.methods
    'getPos': (filter) ->
        self = @
        pipeline = [
            {
                $group:
                    _id: "$user_context_name"
            }
            {
                $sort:
                    _id: 1
            }
        ]
        results = Visits.aggregate(pipeline)
