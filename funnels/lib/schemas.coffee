@Schemas ?= {}

Schemas.Steps = new SimpleSchema(
    name:
        type: String
        label: 'Step name'
    url:
        type: String
        label: 'URL pattern'
)
Steps.attachSchema(Schemas.Steps)

Schemas.Funnels = new SimpleSchema(
    name:
        type: String
        label: 'Funnel name'
    pattern:
        type: String
        label: 'Funnel description'
    steps:
        type: [Schemas.Steps]
)
Funnels.attachSchema(Schemas.Funnels)
