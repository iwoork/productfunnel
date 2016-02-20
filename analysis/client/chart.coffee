Template.chart.onRendered =>
    name = Template.instance().data.name
    step = Template.instance().data.step
    chart = $('#' + name).highcharts()
    Meteor.call 'continuance', step, {}, (err, result) ->
        # Loop
        _.each(result, (point) ->
            #console.log point
            count = [new Date(point.local_date), point.count]
            continuance = [new Date(point.local_date), point.continuance * 100]
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

