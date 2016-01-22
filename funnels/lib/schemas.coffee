@Schemas ?= {}

Schemas.Funnels = new SimpleSchema(
    name:
        type: String
        label: 'Funnel name'
    pattern:
        type: String
        label: 'Funnel description'
)
Funnels.attachSchema(Schemas.Funnels)
