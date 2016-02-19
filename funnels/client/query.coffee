Template.query.helpers
    fields: ->
        filters = Filters.find().fetch()
        fields = []
        _.each(filters, (filter)->
            fields.push filter.field
        )
        fields.join(',\n\t')
    steps: ->
        steps = Session.get 'funnel'
        fields = []
        _.each(steps.steps, (step, index)->
            fields.push 'SUM(STEP' + index + ') AS STEP' + index
        )
        fields.join(',\n\t')
    conditions: ->
        funnel = Session.get 'funnel'
        fields = []
        _.each(funnel.conditions, (condition, index)->
            fields.push condition.field + ' ' + condition.operator + ' ' + condition.value
        )
        fields.join(' AND \n\t')
    groups: ->
        filters = Filters.find().fetch()
        fields = []
        _.each(filters, (filter)->
            console.log filter
            if filter.group
                fields.push filter.field
        )
        fields.join(',\n\t')
    progression: ->
        progression = []
        steps = Session.get 'funnel'
        _.each(steps.steps, (step, index)->
            stepindex=-1
            condition = []
            while stepindex < index
                stepindex++
                statement = 'STEP' + stepindex + '=1'
                console.log statement
                condition.push statement
            terms = condition.join(" AND ")
            progression.push 'MAX(CASE WHEN ' + terms + ' THEN 1 ELSE 0 END) as STEP' + index
        )
        progression.join(',\n\t')   
    values: ->
        progression = []
        steps = Session.get 'funnel'
        _.each(steps.steps, (step, index)->
            progression.push 'MAX(CASE WHEN ' + step.field + '="' + step.pattern + '" THEN 1 ELSE 0 END) as STEP' + index
        )
        progression.join(',\n\t')
