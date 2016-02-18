Router.map ->
    @route 'funnels',
        path: '/funnels'
        controller: FunnelsController
        yieldTemplates:
            empty:
                to: 'aside'
            header:
                to: 'header'
    @route 'steps',
        path: '/steps'
        controller: StepsController
        yieldTemplates:
            empty:
                to: 'aside'
            header:
                to: 'header'
    @route 'filters',
        path: '/filters'
        controller: FiltersController
        yieldTemplates:
            empty:
                to: 'aside'
            header:
                to: 'header'

