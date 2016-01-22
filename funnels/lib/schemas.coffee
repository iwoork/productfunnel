@Schemas ?= {}

Schemas.Funnels = new SimpleSchema(
    name:
        type: String
        label: 'Funnel name'
    pattern:
        type: String
        label: 'Funnel description'
    accountId:
        type: String
        label: 'Account Id'
        autoform:
            type: 'hidden'
            label: false
        autoValue: ->
            @userId
)
Funnels.attachSchema(Schemas.Funnels)
