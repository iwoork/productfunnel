Template.header.rendered = ->

Template.header.events
    'click .btn-logout': ->
        Meteor.logout () ->
            Router.go '/'
    'click .navbar-collapse.in a.menu-close': ->
        $('#main-menu').collapse('hide')
