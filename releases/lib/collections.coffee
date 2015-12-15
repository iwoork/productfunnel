@Releases = new Mongo.Collection('releases')
@Releases.allow
    insert: ->
        true
    update: ->
        true
