Meteor.publish 'dimensions', (filter) ->
    defaults = {accountId: @userId}
    param = filter or defaults
    Dimensions.find(param)
