Meteor.publish 'funnels', (filter) ->
    defaults = {accountId: @userId}
    param = filter or defaults
    Funnels.find(param)

Meteor.publish 'steps', (filter) ->
    defaults = {accountId: @userId}
    param = filter or defaults
    Steps.find(param)
