@Schemas ?= {}

Schemas.Dimensions = new SimpleSchema(
    name:
        type: String
        label: 'Dimension name'
    pattern:
        type: String
        label: 'Dimension description'
)
Dimensions.attachSchema(Schemas.Dimensions)
