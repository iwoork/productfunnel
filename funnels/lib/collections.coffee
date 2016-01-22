@Funnels = new Mongo.Collection('funnels')
@Steps = new Mongo.Collection('steps')

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
