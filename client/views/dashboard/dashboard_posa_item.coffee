Template.dashboard_posa_item.created = ->
    color = "rgba(255,255,255,0.6)"
    options =
        lines: 10
        length: 20
        speed: 1
    selector = ".posa-" + @data.shortcode + " .overlay"

    # add the overlay
    LoadingOverlay.createLoadingOverlay selector, color

    # Set initial dates
    #start_date = new Date(moment().subtract("days", 20))
    #end_date = new Date()
    start_date = new Date('2015-01-01')
    end_date = new Date('2015-12-31')

    posvar = @pos
    posvar = @pos = new ReactiveVar()  unless posvar
    Meteor.call "fetchData",
        pos: @data.shortcode
        date_from: start_date
        date_to: end_date
    , (err, posdata) ->
        if err
            console.log err
        else
            console.log posdata
            LoadingOverlay.destroyLoadingOverlay(selector);
            data = posdata[0]
            items = ['danger', 'success']
            idx = items[Math.floor(Math.random()*items.length)]
            status =
                danger:
                    name: 'danger'
                    icon: 'fa-thumbs-down'
                success:
                    name: 'success'
                    icon: 'fa-thumbs-up'
            data.orders = Math.round(data.visits * (Math.random() * (0.120 - 0.0200) + 0.0200))
            data.cvr = accounting.formatNumber((data.orders/data.visits) * 100, 2)
            data.qscvr = accounting.formatNumber((data.orders/data.visits+8) * 100, 2)
            data.performance = status[idx]
            console.log data.performance
            posvar.set data
        return
    return

Template.dashboard_posa_item.helpers
    'data': ->
        inst = Template.instance()
        posvar = inst and inst["pos"]
        record = posvar.get()
    'status': ->
        items = ['danger','success']
        items[Math.floor(Math.random()*items.length)]

