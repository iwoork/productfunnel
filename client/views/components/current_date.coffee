Template.current_date.onCreated  ->
    @current_date = new ReactiveVar
    current_date = moment(new Date()).subtract(2, 'days')
    @current_date.set current_date

Template.current_date.helpers
    'current_date': ->
        Template.instance().current_date.get()
