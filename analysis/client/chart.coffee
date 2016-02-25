Template.chart.events
    'click .showdata': (event,template) ->
        target = $(event.currentTarget)
        metric =  target.data('metrics')

        # Chart
        chart = $('#' + template.data.name).highcharts()

        # Toggle series
        if target.hasClass('btn-success')
            target.removeClass('btn-success')
            chart.get(metric).remove()
        else
            target.addClass('btn-success')
            data = Session.get template.data.name
            t = metric.toLowerCase()
            chart.addAxis
                id: metric
                title:
                    text: metric
                opposite: true
            chart.addSeries
                name: metric
                data: data.data[t]
                type: 'spline'
                yAxis: metric
                pointInterval: 24 * 3600 * 1000 
                pointRange: 24 * 3600 * 1000


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
        chart.xAxis[0].addPlotLine(plotLine)

        # Loop
        data = {}
        volume = []
        continuance = []
        conversion = []
        _.each(result, (point, index) ->
            #console.log point
            start = result[0]['count']
            #console.log result[0]['count']
            date = moment(point.local_date).format('YYYY-MM-DD')
            volume.push [date, point.count]
            continuance.push [date, point.continuance * 100]
            conversion.push [date, (point.count / start)]
        )
        data.data = {}
        data.data.volume = volume
        data.data.continuance = continuance
        data.data.conversion = conversion
        data.index = step
        Session.set name, data

        # Set initial data
        chart.get('Count').setData(volume)
        chart.get('Continuance').setData(continuance)
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
        series: [
            {
                id: 'Count'
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
                id: 'Continuance'
                name: 'Continuance'
                type: 'spline'
                color: 'red'
                pointInterval: 24 * 3600 * 1000 
                marker:
                    radius: 2
                labels: formatter: ->
                    (@value * 100) + "&#37;"
            }
        ]

