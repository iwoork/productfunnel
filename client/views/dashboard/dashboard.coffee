Template.dashboard.helpers
    'channels': Meteor.settings.public.channels
    'platforms': Meteor.settings.public.platforms
    'visits': accounting.formatNumber(Math.floor((Math.random() * 999999) + 1))
    'orders': accounting.formatNumber(Math.floor((Math.random() * 999999) + 1))
    'cvr': accounting.formatNumber(Math.random() * 100 / 100, {precision: 2}) + '%'
    'qscvr': accounting.formatNumber(Math.random() * 100 / 100, {precision: 2}) + '%'
    'status': ->
        items = ['danger','success']
        items[Math.floor(Math.random()*items.length)]

Template.dashboard.rendered = ->
    $(".chart-gauge").each (i, obj) ->
        $(this).highcharts
            chart:
                type: "solidgauge"
                animation:
                    duration: 5000

            title: null
            pane:
                center: [
                    "50%"
                    "30%"
                ]
                size: "100%"
                startAngle: -90
                endAngle: 90
                background:
                    backgroundColor: "#fff"
                    innerRadius: "60%"
                    outerRadius: "100%"
                    shape: "arc"

            tooltip:
                enabled: false
            yAxis:
                min: 0
                max: 100
                title:
                    text: "Efficiency"

                stops: [
                    [
                        0.1
                        "#DF5353"
                   ]
                    [
                        0.5
                        "#DDDF0D"
                    ]
                    [
                        0.9
                        "#55BF3B"
                   ]
                ]
                lineWidth: 0
                minorTickInterval: null
                tickPixelInterval: 400
                tickWidth: 0
                title:
                    y: -70

                labels:
                    y: 16

            plotOptions:
                solidgauge:
                    dataLabels:
                        y: 5
                        borderWidth: 0
                        useHTML: true

            credits:
                enabled: false

            series: [
                name: "Speed"
                data: [Math.floor(Math.random()* 100)]
                dataLabels:
                    format: "<div style=\"text-align:center\"><span style=\"font-size:25px;color:#7e7e7e\">{y}%</span><br/><span style=\"font-size:13px;color:#7e7e7e\">efficiency</span></div>"
            ]

    $('.chart-gauge').css('height', '180px');

