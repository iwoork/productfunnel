Template.registerHelper 'route', () ->
    Router.current().route.getName()
