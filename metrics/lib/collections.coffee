@Hits = new Mongo.Collection('hits')
@Hits.allow
    insert: ->
        true
    update: ->
        true
