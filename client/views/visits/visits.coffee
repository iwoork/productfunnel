volumeChart = (selector, entry) ->
    $(selector).highcharts
        chart: 
            type: 'spline'
            animation: Highcharts.svg
            zoomType: 'x'
        title: text: entry
        credits: enabled: false
        xAxis:
            title: 
                text: 'Day'
            type: 'datetime'
            crosshair: true
        yAxis:
            title: text: 'Visits'
            labels: formatter: ->
                @value / 1000 + 'k'
        plotOptions: area:
            marker:
                enabled: false
                symbol: 'circle'
                radius: 2
                states: hover: enabled: true
            spline:
                lineWidth: 1
        series: [
            {
                name: 'This year'
                color: 'red'
            }
            {
                name: 'Last year'
                color: 'orange'
            }
        ]

    Meteor.call 'getVisits', {
        entry_page_name: entry
        local_date:
            $gte: new Date(moment().subtract("days", 445))
            $lt: new Date(moment().subtract("years", 1))
    }, (err, data) ->
                chart = $(selector).highcharts()
                dataset = []
                _.each(data, (row) ->
                    point = []
                    point[0] = moment.months(row._id.month - 1) + ' ' + row._id.day
                    if entry == 'HOME PAGE'
                        point[1] = row.home
                    if entry == 'SEARCH RESULT WITH DATES'
                        point[1] = row.search
                    if entry == 'HOTEL DETAILS PAGE DESCRIPTION TAB'
                        point[1] = row.pdp
                    chart.series[1].addPoint(point)
                    dataset.push(point[1])
                )
                return
    Meteor.call 'getVisits', {
        entry_page_name: entry
        local_date:
            $gte: new Date(moment().subtract("days", 89))
            $lt: new Date() 
    }, (err, data) ->
                chart = $(selector).highcharts()
                dataset = []
                _.each(data, (row) ->
                    point = []
                    point[0] = moment.months(row._id.month - 1)  + ' ' + row._id.day
                    if entry == 'HOME PAGE'
                        point[1] = row.home
                    if entry == 'SEARCH RESULT WITH DATES'
                        point[1] = row.search
                    if entry == 'HOTEL DETAILS PAGE DESCRIPTION TAB'
                        point[1] = row.pdp
                    chart.series[0].addPoint(point)
                    dataset.push(point[1])
                )
                mean = ss.mean(dataset)
                sd = ss.standard_deviation(dataset)
                chart.yAxis[0].addPlotBand(
                    color: 'rgba(68, 170, 213, 0.1)',
                    label:
                        text: 'Normal range'
                        style:
                            color: '#606060'
                    from: mean - sd
                    to:  mean + sd
                )
                return

getVisits = ->
    conversionChart('.conversions-home', 'HOME PAGE')
    return

Template.visits.rendered = ->
    getVisits()
    return

