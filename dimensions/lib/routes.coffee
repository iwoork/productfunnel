Router.map ->
    @route 'dimensions',
        path: '/dimensions'
        controller: DimensionsController
        yieldTemplates:
            empty:
                to: 'aside'
            header:
                to: 'header'

