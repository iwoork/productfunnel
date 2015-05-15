renderChart = ->
    console.log 'Chart created'
    $('.modal-chart').highcharts
        chart: 
            type: 'spline'
            animation: Highcharts.svg
            zoomType: 'x'
            id: 'investigate'
            width: 715
        title: text: ''
        credits: enabled: false
        tooltip:
            shared: true
        xAxis:
            title: 
                text: 'Day'
            #type: 'datetime'
            crosshair: true
        yAxis: [
            {
                title: text: 'Visits'
                labels: formatter: ->
                    @value / 1000 + 'k'
            }
            {
                title: text: 'CVR'
                labels: formatter: ->
                    @value + '%'
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
                id: 'visits'
                name: 'Visits'
                color: '#5bc0de'
                type: 'column'
                yAxis: 0
            }
            {
                id: 'conversions'
                name: 'Conversions'
                color: 'red'
                type: 'spline'
                yAxis: 1
            }
       ]

    #data = @Visits.find()
    #chart = $(selector).highcharts()
    #console.log data
    #_.each(data, (row) ->
    #    point = []
    #    point[0] = moment.months(row._id.month - 1) + ' ' + row._id.day
    #    if entry == 'HOME PAGE'
    #        point[1] = row.home_cvr
    #    if entry == 'SEARCH RESULT WITH DATES'
    #        point[1] = row.search_cvr
    #    if entry == 'HOTEL DETAILS PAGE DESCRIPTION TAB'
    #        point[1] = row.pdp_cvr
    #    chart.get('visits').addPoint(point)
    #    dataset.push(point[1])
    #)

Template.modal.onCreated ->
   return

Template.modal.onRendered ->
    renderChart()
    return

