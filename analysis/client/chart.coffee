Template.chart.onRendered =>
    name = Template.instance().data.name
    step = Template.instance().data.step
    chart = $('#' + name).highcharts()
    Meteor.call 'continuance', step, {}, (err, result) ->
        # Loop
        _.each(result, (point) ->
            #console.log point
            date = Date(point.local_date + 'Z')
            count = [date, point.count]
            continuance = [date, point.continuance * 100]
            chart.get('count').addPoint(count,false)
            chart.get('continuance').addPoint(continuance,false)
            chart.redraw()
        )

        # Add releases
        plotOptions = {
            id: step,
            color: '#FF0000',
            dashStyle: 'ShortDash',
            width: 2,
            value: new Date('2016-02-03'),
            zIndex: 0,
            label : {
                text : 'Goal'
            }
        }
        chart.yAxis[0].addPlotLine(plotOptions)
    return

Template.chart.helpers
    stepChart: ->
        chart:
            animation: Highcharts.svg
            zoomType: 'x'
        title: text: 'Count vs Continuance'
        credits: enabled: false
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
                title: text: 'Count'
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

