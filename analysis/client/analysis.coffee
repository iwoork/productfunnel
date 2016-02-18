Template.analysis.helpers
    'steps': ->
        funnel = Funnels.findOne()
        funnel.steps
    stepChart: ->
        chart:
            type: 'spline'
            animation: Highcharts.svg
            zoomType: 'x'
        title: text: 'Trend Analysis'
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

