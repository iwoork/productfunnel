class @EntryController extends RouteController 
    waitOn: ->
        now = new Date()
        m = now.getMonth() + 1
        y = now.getFullYear()
        d = now.getDate() - 1
        current_end = new Date(y + '-' + m  + '-' + d) # today
        current_start = new Date(moment(current_end).subtract("days", 29)) # 1 month
        previous_end = new Date(moment(current_end).subtract("year", 1))
        previous_start = new Date(moment(current_start).subtract("year", 1))
        console.log "ce: " + current_end
        console.log "cs: " + current_start
        console.log "pe: " + previous_end
        console.log "ps: " + previous_start
        range = {
            $or: [
                {
                    local_date:
                        $gte: current_start
                        $lt: current_end
                }
                #{
                #    local_date:
                #        $gte: previous_start
                #        $lt: previous_end
                #}
            ]
        }
        group = {
            month:
                $month: "$local_date"
            day:
                $dayOfMonth: "$local_date"
            year:
                $year: "$local_date"
            dayOfWeek:
                $dayOfWeek: "$local_date"
            entry_page_name: "$entry_page_name"
        }
        [
            Meteor.subscribe('visits', range, group)
        ]

    data: ->
        self = @
