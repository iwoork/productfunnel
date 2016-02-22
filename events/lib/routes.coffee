Router.map ->
    @route 'events',
        path: '/events'
        controller: EventsController
        yieldTemplates:
            empty:
                to: 'aside'
            header:
                to: 'header'

