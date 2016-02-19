Template.analysis.helpers
    funnel: ->
        Session.get 'funnel'
    stepChart: ->
        chart:
            animation: Highcharts.svg
            zoomType: 'x'
        title: text: 'Trend Analysis'
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
                symbol: 'circle'
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
                    @value * 100 + '%'
           }
        ]

Template.analysis.onRendered =>
    funnel = Session.get 'funnel'
    _.each(funnel.steps, (step,index)->
        Meteor.call 'continuance', index, {}, (err, result) ->
            chart = $('#' + step.name).highcharts()

            #Reset data points
            #chart.get('count').setData []
            #chart.get('continuance').setData []

            # Loop
            _.each(result, (point) ->
                console.log point
                count = [new Date(point.local_date), point.count]
                continuance = [new Date(point.local_date), point.continuance * 100]
                chart.get('count').addPoint(count)
                chart.get('continuance').addPoint(continuance)
           )
    )
    return
