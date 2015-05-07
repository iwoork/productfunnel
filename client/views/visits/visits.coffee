conversionChart = (selector, entry) ->
    $(selector).highcharts
        chart: 
            type: 'spline'
            animation: Highcharts.svg
            zoomType: 'x'
        title: text: entry + ' Conversion'
        credits: enabled: false
        tooltip:
            shared: true
            formatter: ->
                points = this.points
                markup  = ''
                for point in points
                    markup += '<b>'+ Highcharts.numberFormat(points[point].y * 100, 2) + '%</b>';
                markup
        xAxis:
            title: 
                text: 'Day'
            type: 'datetime'
            crosshair: true
        yAxis: [
            {
                title: text: 'CVR'
                labels: formatter: ->
                    @value * 100 + '%'
            }
            {
                title: text: 'BPS'
                labels: formatter: ->
                    @value + 'BPS'
                opposite: true
            }
        ]
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
                id: 'this-year'
                name: 'This year'
                color: 'red'
                type: 'spline'
            }
            {
                id: 'last-year'
                name: 'Last year'
                color: 'orange'
                type: 'spline'
            }
            {
                name: 'BPS'
                color: 'blue'
                type: 'column'
                yAxis: 1
            }
        ]

    # This year
    Meteor.call 'getConversions', {
        entry_page_name: entry
        local_date:
            $gte: new Date(moment().subtract("months", 3))
            $lt: new Date()
    }, (err, data) ->
        if err
            console.log err
        else
            chart = $(selector).highcharts()
            dataset = []
            _.each(data, (row) ->
                point = []
                point[0] = moment.months(row._id.month - 1) + ' ' + row._id.day
                if entry == 'HOME PAGE'
                    point[1] = row.home_cvr
                if entry == 'SEARCH RESULT WITH DATES'
                    point[1] = row.search_cvr
                if entry == 'HOTEL DETAILS PAGE DESCRIPTION TAB'
                    point[1] = row.pdp_cvr
                chart.get('this-year').addPoint(point)
                dataset.push(point[1])
            )
            return

    # Last year
    Meteor.call 'getConversions', {
        entry_page_name: entry
        local_date:
            $gte: new Date(moment().subtract("days", 445))
            $lt: new Date(moment().subtract("years", 1))
    }, (err, data) ->
        if err
            console.log err
        else
            chart = $(selector).highcharts()
            dataset = []
            _.each(data, (row) ->
                point = []
                point[0] = moment.months(row._id.month - 1) + ' ' + row._id.day
                if entry == 'HOME PAGE'
                    point[1] = row.home_cvr
                if entry == 'SEARCH RESULT WITH DATES'
                    point[1] = row.search_cvr
                if entry == 'HOTEL DETAILS PAGE DESCRIPTION TAB'
                    point[1] = row.pdp_cvr
                chart.get('last-year').addPoint(point)
                dataset.push(point[1])
            )
            return

yoyChart = (selector, entry) ->
    $(selector).highcharts
        chart: 
            type: 'spline'
            animation: Highcharts.svg
            zoomType: 'x'
        title: text: entry + ' BPS'
        credits: enabled: false
        xAxis:
            title: 
                text: 'Day'
            type: 'datetime'
            crosshair: true
        yAxis:
            title: text: 'YoY Visits'
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
                id: 'yoy'
                name: 'Last year'
                color: 'orange'
            }
        ]

    Meteor.call 'getYoy', {
        entry_page_name: entry
        local_date:
            $gte: new Date(moment().subtract("days", 445))
            $lt: new Date(moment().subtract("years", 1))
    }, (err, data) ->
        if err
            console.log err
        else
            console.log data
            chart = $(selector).highcharts()
            console.log data
            dataset = []
            _.each(data, (row) ->
                point = []
                point[0] = moment.months(row._id.month - 1) + ' ' + row._id.day
                point[1] = row.yoy
                chart.get('yoy').addPoint(point)
                dataset.push(point[1])
            )
            return

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
    volumeChart('.visits-home', 'HOME PAGE')
    yoyChart('.yoy-home', 'HOME PAGE')
    #volumeChart('.visits-srp', 'SEARCH RESULT WITH DATES')
    #volumeChart('.visits-pdp', 'HOTEL DETAILS PAGE DESCRIPTION TAB')
    return

Template.visits.rendered = ->
    getVisits()
    return


