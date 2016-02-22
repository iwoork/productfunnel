Meteor.publish 'events', (filter) ->
    defaults = {}
    param = filter or defaults
    Events.find(param)

