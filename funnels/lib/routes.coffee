Router.map ->
    @route 'funnels',
        path: '/funnels'
        controller: FunnelsController
        yieldTemplates:
            empty:
                to: 'aside'
            header:
                to: 'header'

