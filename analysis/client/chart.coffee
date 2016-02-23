Template.chart.onRendered =>
    name = Template.instance().data.name
    step = Template.instance().data.step
    chart = $('#' + name).highcharts()
    funnel = Session.get 'funnel'

    Meteor.call 'continuance', step, {key: funnel.key}, (err, result) ->
        chart.showLoading('Loading data from server...')
        # Add releases
        plotLine = {
            id: 'test'
            color: 'orange',
            dashStyle: 'shortDashDot'
            width: 2
            value: moment('1970-01-21')
            zIndex: 2
            label:
                text: 'R2015.25.0'
                verticalAlign: 'top'
                textAlign: 'left'
        }
        #plotBand = {
        #    from: new Date('1970-02-03'),
        #    to: new Date('1970-02-10'),
        #    color: '#f7f9e4',
        #    id: 'plot-band-1'
        #    label:
        #        text: 'Chinese New Year'
        #}
        chart.xAxis[0].addPlotLine(plotLine)
        #chart.xAxis[0].addPlotBand(plotBand)

        # Loop
        volume = []
        continuance = []
        _.each(result, (point) ->
            console.log point
            date = moment(point.local_date).format('YYYY-MM-DD')
            volume.push [date, point.count]
            continuance.push [date, point.continuance * 100]
       )
        chart.get('count').setData(volume)
        chart.get('continuance').setData(continuance)
        chart.hideLoading()
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
                title: 
                    text: 'Continuance'
                    color: 'red'
                opposite: true
            }
            {
                title: text: 'Volume'
            }
        ]
        plotOptions:
            column:
                animation: true
        series: [
            {
                id: 'count'
                yAxis: 1
                name: 'Volume'
                type: 'column'
                color: '#bce8f1'
                pointInterval: 24 * 3600 * 1000 
                pointRange: 24 * 3600 * 1000
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

