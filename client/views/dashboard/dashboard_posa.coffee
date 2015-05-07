Template.dashboard_posa.helpers
    'posa': Meteor.settings.public.posa
    'status': ->
        items = ['danger','success']
        items[Math.floor(Math.random()*items.length)]

Template.dashboard_posa.rendered = ->
    $isotope = $(".isotope-posa").isotope(
        itemSelector: ".col-sm-3"
        getSortData:
            visits: "[data-visits]"
            orders: "[data-orders]"
            cvr: "[data-cvr]"
    )
    $("#sort-posa").on "click", "button", ->
        sortByValue = $(this).attr("data-sort-by")
        $isotope.isotope
            sortBy: sortByValue
            sortAscending:
                visits: false
                orders: false
                cvr: false
        return

