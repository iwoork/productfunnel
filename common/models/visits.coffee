@Visits =
    findAll: (filters, limit) ->
        filters = _.extend(
            filters or {}
        ,
            {
                'pos' : 'hk'
            }
        )

        Visits.find(filters, {
            limit: limit or 0
            sort: {
                'report_date': -1
            }
        })
