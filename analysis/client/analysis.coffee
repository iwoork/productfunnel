Template.analysis.onRendered =>
    $ ->
        $affix = $('#sidebar')
        $affix.affix()
        $parent = $affix.parent()

        resize = ->
            $affix.width $parent.width()
            return

        $(window).resize resize
        resize()
        return

Template.analysis.helpers
    funnel: ->
        Session.get 'funnel'


