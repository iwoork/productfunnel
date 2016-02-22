@Events = new Mongo.Collection('events')

@Events.allow
    insert: ->
        true
    update: ->
        true
