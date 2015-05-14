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

getVisits = ->
    conversionChart('.conversions-home', 'HOME PAGE')
    return

Template.modal.rendered = ->
    getVisits()
    return

