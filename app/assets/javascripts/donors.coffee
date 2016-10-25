# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "page:change", ->
# hide the forms
  $('#gen-form').hide 0
  $('#com-form').hide 0

# show and hide the donation form

  $('#btn_donor_item_toggle').click (e) ->
    e.stopPropagation();
    e.preventDefault();
    if $('#gen-form').is(':visible')
      closeItemForm()
      return true
    else
      openItemForm()
      return true

  closeItemForm = () ->
      $('#gen-form').slideUp "fast"
      $('#btn_donor_item_toggle').text('Add Donation')
      #reset the form
      $('#new_item')[0].reset()
      return true

  openItemForm = () ->
      $('#gen-form').slideDown "fast"
      $('#btn_donor_item_toggle').text('Cancel')
      return true

  $('#btn_donor_contact_toggle').click (e) ->
    e.stopPropagation();
    e.preventDefault();
    if $('#com-form').is(':visible')
      closeContactForm()
      return true
    else
      openContactForm()
      return true

  closeContactForm = () ->
      $('#com-form').slideUp "fast"
      $('#btn_donor_contact_toggle').text('Record a Contact')
      #reset the form
      $('#new_contact')[0].reset()
      return true

  openContactForm = () ->
      $('#com-form').slideDown "fast"
      $('#btn_donor_contact_toggle').text('Cancel')
      return true

  return true;
