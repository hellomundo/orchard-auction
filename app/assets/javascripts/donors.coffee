# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "page:change", ->
# hide the forms
  $('#gen-form').hide 0
  $('#contact-add-form').hide 0

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

# show and hide the contact form
  $('#contact-cancel-button').click ->
    $('#contact-add-form').slideUp "fast"
    $('#contact-add-button').show 0

  $('#contact-add-button').click ->
    $('#contact-add-form').slideDown "fast"
    $('#contact-add-button').hide 0

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

  return true;
