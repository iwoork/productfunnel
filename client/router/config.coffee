Router.configure
    layoutTemplate: 'layout'
    trackPageView: true
    fastRender: true
    yieldTemplates:
        header: { to: 'header' }
        filters: { to: 'aside' }
        footer: { to: 'footer' }
