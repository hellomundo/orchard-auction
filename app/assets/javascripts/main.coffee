$(document).on "turbolinks:load", ->

  window.App = {}

  App.initPanel = (form_name) ->
    $('#' + form_name + '-panel').hide 0

    $('#' + form_name + '-btn').click (e) ->
      e.stopPropagation();
      e.preventDefault();
      if $('#' + form_name + '-panel').is(':visible')
        App.closeForm(form_name)
        return true
      else
        App.openForm(form_name)
        return true

  App.closeForm = (form_name) ->
      $('#' + form_name + '-panel').slideUp "fast"
      $('#' + form_name + '-btn').text('New')
      #reset the form
      $('#' + form_name + '-form').find("form")[0].reset()
      return true

  App.openForm = (form_name) ->
      $('#' + form_name + '-panel').slideDown "fast"
      $('#' + form_name + '-btn').text('Cancel')
      return true

  return true;
