@Dimensions = new Mongo.Collection('dimensions')
@Dimensions.allow
    insert: ->
        true
    update: ->
        true
