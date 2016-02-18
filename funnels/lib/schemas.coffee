@Schemas ?= {}

Schemas.Steps = new SimpleSchema(
    name:
        type: String
        label: 'Step name'
    field:
        type: String
        label: 'Field name'
    pattern:
        type: String
        label: 'Pattern match'
    weight:
        type: String
        label: 'Weight'
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

Schemas.Filters = new SimpleSchema(
    name:
        type: String
        label: 'Filter name'
    field:
        type: String
        label: 'Field name'
    group:
        type: Boolean
        label: 'Grouped?'
)
Filters.attachSchema(Schemas.Filters)
