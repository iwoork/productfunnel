Template.datepicker.rendered = ->
    $("#date-pick").daterangepicker
        ranges:
            Today: [
                new Date()
                new Date()
            ]
            Yesterday: [
                moment().subtract("days", 1)
                moment().subtract("days", 1)
            ]
            "Last 7 Days": [
                moment().subtract("days", 6)
                new Date()
            ]
            "Last 30 Days": [
                moment().subtract("days", 29)
                new Date()
            ]
            "This Month": [
                moment().startOf("month")
                moment().endOf("month")
            ]
            "Last Month": [
                moment().subtract("month", 1).startOf("month")
                moment().subtract("month", 1).endOf("month")
            ]

        opens: "left"
        format: "YYYY-MM-DD"
        startDate: "2014-01-01"
        separator: ' to '
        endDate: "2015-01-25"
    , (start, end) ->
        $("#daterange span").html start.format("MMMM D, YYYY") + " - " + end.format("MMMM D, YYYY")
        return
    start_date = new Date(moment().subtract("days", 29))
    end_date = new Date()
    $('#date-pick').data('daterangepicker').setStartDate(start_date)
    $('#date-pick').data('daterangepicker').setEndDate(end_date)
    $("#date-pick").on "apply.daterangepicker", (ev, picker) ->
        Session.set 'date_from', new Date(picker.startDate.format("YYYY-MM-DD")).toISOString()
        Session.set 'date_to', new Date(picker.endDate.format("YYYY-MM-DD")).toISOString()
        return

