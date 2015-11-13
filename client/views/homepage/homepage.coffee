Template.homepage.created = ->
    posvar = @visits
    posvar = @visits = new ReactiveVar()  unless posvar
    # Get current year
    Meteor.call "fetchVisits",
        pos: 'cn'
        date:
            $gte: new Date(moment().subtract("days", 20)).toISOString()
            $lt:  new Date().toISOString()
    , (err, records) ->
        if err
            console.log err
        else
            data = []
            i = 0
            while i < records.length
                record = [
                    new Date(records[i].date)
                    records[i].visits
                ]
                data.push record
            console.log data
            posvar.set data
            Session.set 'visits', data
        return

Template.homepage.helpers
    'data': ->
        inst = Template.instance()
        posvar = inst and inst["visits"]
        record = posvar.get()
        console.log record
        record

    'volume': ->
        chart:
            plotBackgroundColor: null
            plotBorderWidth: null
            plotShadow: false

        title:
            text: "Homepage entries"

        subtitle:
            text: "Volume of entries on the homepage"

        tooltip:
            pointFormat: "<b>{point.percentage:.1f}%</b>"

        plotOptions:
            dataLabels:
                enabled: true
                format: "<b>{point.name}</b>: {point.percentage:.1f} %"
                style:
                    color: (Highcharts.theme and Highcharts.theme.contrastTextColor) or "black"
                connectorColor: "silver"
        series: [
            {
                name: "LAST YEAR"
                color: 'orange'
                data: Session.get 'visits'
            }
            {
                name: "THIS YEAR"
                color: 'red'
                data: Session.get 'visits'
            }
        ]

    # Homepage -> SRP
    'homepage_srp':
        chart:
            plotBackgroundColor: null
            plotBorderWidth: null
            plotShadow: false

        title:
            text: "Homepage to SRP continuance"

        subtitle:
            text: "Continuance to SRP"

        xAxis:
            categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']

        tooltip:
            pointFormat: "<b>{point.percentage:.1f}%</b>"

        plotOptions:
            dataLabels:
                enabled: true
                format: "<b>{point.name}</b>: {point.percentage:.1f} %"
                style:
                    color: (Highcharts.theme and Highcharts.theme.contrastTextColor) or "black"
                connectorColor: "silver"
        series: [
            {
                name: "LAST YEAR"
                color: 'orange'
                data: [124,1241,1241,1241,1214,1516,6222,6246,7574,2362,2623,2626]
            }
            {
                name: "THIS YEAR"
                color: 'red'
            }
        ]

    # Homepage -> SRP -> PDP
    'homepage_srp_pdp':
        chart:
            plotBackgroundColor: null
            plotBorderWidth: null
            plotShadow: false

        title:
            text: "SRP to PDP continuance"

        subtitle:
            text: "Continuance to PDP"

        xAxis:
            categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']

        tooltip:
            pointFormat: "<b>{point.percentage:.1f}%</b>"

        plotOptions:
            dataLabels:
                enabled: true
                format: "<b>{point.name}</b>: {point.percentage:.1f} %"
                style:
                    color: (Highcharts.theme and Highcharts.theme.contrastTextColor) or "black"
                connectorColor: "silver"
        series: [
            {
                name: "LAST YEAR"
                color: 'orange'
            }
            {
                name: "THIS YEAR"
                color: 'red'
            }
        ]
