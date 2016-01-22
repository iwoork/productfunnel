@Schemas ?= {}

Schemas.Hits = new SimpleSchema(
    hitDate:
        type: Date
        label: 'Hit date'
)
Hits.attachSchema(Schemas.Hits)
