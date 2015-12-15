@Schemas ?= {}

Schemas.Releases = new SimpleSchema(
    name:
        type: String
        label: 'Name'
    pod:
        type: Date
        label: 'Pod Sign Off'
    ppemilan:
        type: Date
        label: 'PPE/Milan'
    soft:
        type: Date
        label: 'Soft Launch'
    phase1:
        type: Date
        label: 'Phase 1'
    phase2:
        type: Date
        label: 'Phase 2'
    phase3:
        type: Date
        label: 'Phase 3'
    sprint:
        type: String
        label: 'Sprint'
)
Releases.attachSchema(Schemas.Releases)
