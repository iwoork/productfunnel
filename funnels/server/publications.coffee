Meteor.publish 'funnels', (filter) ->
    defaults = {accountId: @userId}
    param = filter or defaults
    Funnels.find(param)
