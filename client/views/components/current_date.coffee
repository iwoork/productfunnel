Template.current_date.onCreated  ->
    @current_date = new ReactiveVar
    now = new Date()
    m = now.getMonth() + 1
    y = now.getFullYear()
    d = now.getDate() - 1
    current_date = new Date(y + '-' + m  + '-' + d) # today
    @current_date.set current_date

Template.current_date.helpers
    'current_date': ->
        Template.instance().current_date.get()
