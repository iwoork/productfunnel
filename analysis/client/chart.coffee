Template.chart.onRendered =>
    name = Template.instance().data.name
    step = Template.instance().data.step
    chart = $('#' + name).highcharts()
    Meteor.call 'continuance', step, {}, (err, result) ->
        # Add releases
        plotLine = {
            id: 'test'
            color: 'orange',
            dashStyle: 'shortDashDot'
            width: 2
            value: new Date('1970-02-01')
            zIndex: 2
            label:
                text: 'R2016.01'
                verticalAlign: 'top'
                textAlign: 'left'
        }
        plotBand = {
            from: new Date('1970-02-03'),
            to: new Date('1970-02-10'),
            color: '#f7f9e4',
            id: 'plot-band-1'
            label:
                text: 'Chinese New Year'
        }
        chart.xAxis[0].addPlotLine(plotLine)
        chart.xAxis[0].addPlotBand(plotBand)

        # Loop
        _.each(result, (point) ->
            console.log point
            date = moment(point.local_date).format('MM/DD/YYYY')
            count = [date, point.count]
            continuance = [date, point.continuance * 100]
            chart.get('count').addPoint(count,false)
            chart.get('continuance').addPoint(continuance,false)
            chart.redraw()
        )

    return

Template.chart.helpers
    stepChart: ->
        chart:
            animation: Highcharts.svg
            zoomType: 'x'
        title: text: 'Volume vs Continuance'
        credits: enabled: false
        tooltip:
            shared: true
        xAxis:
            title: 
                text: 'Date'
            type: 'datetime'
            crosshair: true
        yAxis: [
            {
                title: text: 'Continuance'
                opposite: true
            }
            {
                title: text: 'Volume'
            }
        ]
        plotOptions: area:
            marker:
                enabled: false
                radius: 2
                states: hover: enabled: true
        series: [
            {
                id: 'count'
                yAxis: 1
                name: 'Count'
                type: 'column'
                color: '#bce8f1'
                pointInterval: 24 * 3600 * 1000 
                labels: formatter: ->
                    @value + 'k'
            }
            {
                id: 'continuance'
                name: 'Continuance'
                type: 'spline'
                color: 'red'
                pointInterval: 24 * 3600 * 1000 
                labels: formatter: ->
                    (@value * 100) + "&#37;"
           }
        ]

