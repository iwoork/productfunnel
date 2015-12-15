Router.map ->
    @route 'releases',
        path: '/releases'
        controller: ReleasesController
        yieldTemplates:
            empty:
                to: 'aside'
            header:
                to: 'header'

