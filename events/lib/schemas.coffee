@Schemas ?= {}

Schemas.Events = new SimpleSchema(
    name:
        type: String
        label: 'Event name'
    start:
        type: Date
        label: 'Start date'
    end:
        type: Date
        label: 'End date'
)
Events.attachSchema(Schemas.Events)
