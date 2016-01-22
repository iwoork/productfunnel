Meteor.methods
    'totalPages': (pattern) ->
        @unblock()
        console.log 'Fetching urls using pattern... ', pattern
        Links.find({
            url:
                "$regex": pattern
        }).count()

