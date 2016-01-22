@Schemas ?= {}

Schemas.Dimensions = new SimpleSchema(
    name:
        type: String
        label: 'Dimension name'
    pattern:
        type: String
        label: 'Dimension description'
    values:
        type: [String]
        label: 'Values'
)
Dimensions.attachSchema(Schemas.Dimensions)
