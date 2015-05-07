Template.pos.helpers
    'results': ->
        #color = 'rgba(255,255,255,0.6)'
        #options = 
        #    lines: 10
        #    length: 20
        #    speed: 1
        #selector = '.overlay'
        #LoadingOverlay.createLoadingOverlay selector, color
        #$('.spinner').remove()
        #LoadingOverlay.createNewSpinner 'loading', options
        ReactiveMethod.call 'getPos'

