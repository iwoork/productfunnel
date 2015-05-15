Router.map ->
    @route 'default',
        path: '/'

    @route '/dashboard',
        name: 'dashboard'
        template: 'dashboard'
        controller: DashboardController
        yieldTemplates:
            header:
                to: 'header'

    @route '/homepage',
        name: 'homepage'
        template: 'homepage'
        controller: HomepageController

    @route '/visits',
        name: 'visits'
        template: 'visits'
        controller: VisitController

    @route '/channels',
        name: 'channels'
        template: 'channels'
        controller: ChannelController
        yieldTemplates:
            empty:
                to: 'aside'
            header:
                to: 'header'

    @route '/platforms',
        name: 'platforms'
        template: 'platforms'
        controller: PlatformController
        yieldTemplates:
            empty:
                to: 'aside'
            header:
                to: 'header'

 
    @route '/entries',
        name: 'entries'
        template: 'entries'
        controller: EntryController
        yieldTemplates:
            empty:
                to: 'aside'
            header:
                to: 'header'

    @route '/browsers',
        name: 'browsers'
        template: 'browsers'
        controller: BrowserController
        yieldTemplates:
            empty:
                to: 'aside'
            header:
                to: 'header'

    @route '/pos',
        name: 'pos'
        template: 'pos'
        controller: PosController
        yieldTemplates:
            empty:
                to: 'aside'
            header:
                to: 'header'

