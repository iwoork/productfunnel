Meteor.methods
    'getChannels': (filter) ->
        self = @
        pipeline = [
            {
                $group:
                    _id: "$mktg_sub_chnnl_name"
            }
            {
                $sort:
                    _id: 1
            }
        ]
        results = Visits.aggregate(pipeline)

