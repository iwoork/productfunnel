@Funnels = new Mongo.Collection('funnels')
@Steps = new Mongo.Collection('steps')
@Filters = new Mongo.Collection('filters')

@Funnels.allow
    insert: ->
        true
    update: ->
        true
@Steps.allow
    insert: ->
        true
    update: ->
        true
@Filters.allow
    insert: ->
        true
    update: ->
        true
