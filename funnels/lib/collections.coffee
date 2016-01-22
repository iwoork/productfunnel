@Funnels = new Mongo.Collection('funnels')
@Funnels.allow
    insert: ->
        true
    update: ->
        true
