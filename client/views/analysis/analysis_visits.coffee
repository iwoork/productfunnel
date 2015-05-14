growth = (current, previous) ->
    if previous == 0
        calc = 0
    else
        calc = (current / previous) - 1
    calc

getOutliers = (data) ->
    # Calculate what's normal
    #console.log data
    outliers = {}
    outliers.today = data[0]
    data.shift()
    min = ss.min data
    max = ss.max data
    mean = ss.mean data
    sd = ss.standard_deviation data
    top = mean + sd
    bottom = mean - sd

    success = []
    warn = []
    cvr = []
    i = 0
    # Take the last 2 same DoW
    while i < 2
        if data[i] > top
            success.push i
        if data[i] < bottom
            warn.push i
        i++
    outliers.mean = mean
    outliers.stdev = sd
    outliers.min = min
    outliers.max = max
    outliers.success = success
    outliers.warn = warn
    #console.log outliers
    outliers

interpret = (results) ->
    response = {}
    success = results.success.length
    warn = results.warn.length
    response.mean = accounting.formatNumber results.mean
    response.min = accounting.formatNumber results.min
    response.max = accounting.formatNumber results.max
    response.today = accounting.formatNumber results.today
    response.stdev = accounting.formatNumber results.stdev
    if warn > 2
        response.status = 'danger'
        response.text = 'Alert!'
    else if warn == 0
        response.status = 'info'
        response.text = 'Normal'
    else if warn == 1
        response.status = 'warning'
        response.text = 'Warning'
    else 
        if success > 0
            response.status = 'success'
            response.text = 'Awesome!'
        else
            response.status = 'info'
            response.text = 'Normal'
    Template.instance().visits.set response

analyze = (funnel,  current) ->
    console.log current
    total = current.length
    dow = moment().day() + 1
    result = []
    i = 0
    while i < total - 1
        if current[i].dayOfWeek == dow
            val = current[i][funnel]
            if val > 0
                result.push current[i][funnel]
        i++
    #console.log result
    outliers = getOutliers result

Template.analysis_visits.onCreated  ->
    @visits = new ReactiveVar
    initial = {
        status: 'default'
        text: 'No data'
        entry: @data.entry
    }
    @visits.set initial

    current = {
        year: 2015
    }
    current[@data.field] =  @data.value
    previous = {
        year: 2014
    }
    previous[@data.field] = @data.value
    sort = {
        sort:
            month: -1
            day: -1
    }
    #console.log current
    current_data = Visits.find(current, sort).fetch()
    #previous_data = Visits.find(previous, sort).fetch()
    result = analyze(@data.funnel, current_data)
    interpret result

Template.analysis_visits.helpers
    'visits': ->
       Template.instance().visits.get()
