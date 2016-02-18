Router.map ->
    @route 'analysis',
        path: '/analysis/:_id'
        controller: AnalysisController
        yieldTemplates:
            empty:
                to: 'aside'
            header:
                to: 'header'

