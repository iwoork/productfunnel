calculateMean = (data) ->
    sum = 0
    i = 0
    len =  data.length
    while i < len
        sum += data[i].visits
        i++
    mean = parseInt(sum / len, 0)
    mean

calculateStandardDeviation = (data) ->

calculateOutliers = (data, sd) ->

calculateStatus = (data) ->
    calculateMean(data)
