Meteor.publish 'releases', (filter) ->
    defaults = {}
    param = filter or defaults
    Releases.find(param)
