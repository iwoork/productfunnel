Template.analysis.onRendered =>
    $ ->
        $affix = $('#sidebar')
        option = {
            offset: 
                top: 400
        }
        $affix.affix(option)
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


