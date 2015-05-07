@Filters = {
    compose: (filters, schema) ->
        $and = []

        # POSa
        $or = []
        _.each(filters.posa || [], (nh) ->
            tmp = {}

            # if null
            if nh is 'others'
                nh = {$in : [null, false] }

            tmp[ FilterSchemas[schema].posa ] = nh
            $or.push(tmp)
        )
        if not _.isEmpty($or)
            $and.push $or: $or

        # channels
        $or = []
        _.each(filters.channels || [], (nh) ->
            tmp = {}

            # if null
            if nh is 'others'
                nh = {$in : [null, false] }

            tmp[ FilterSchemas[schema].channel ] = nh
            $or.push(tmp)
        )
        if not _.isEmpty($or)
            $and.push $or: $or

        # platform
        $or = []
        _.each(filters.platforms || [], (nh) ->
            tmp = {}

            # if null
            if nh is 'others'
                nh = {$in : [null, false] }

            tmp[ FilterSchemas[schema].platform ] = nh
            $or.push(tmp)
        )
        if not _.isEmpty($or)
            $and.push $or: $or

        if $and.length
            return { $and : $and }

        {}
}

@FilterSchemas = {
    visits: {
        'posa': 'posa'
        'channel': 'channel'
        'platform': 'platform'
    }
}
