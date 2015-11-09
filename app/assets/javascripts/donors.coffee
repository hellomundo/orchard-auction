# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "page:change", ->
# hide the forms
  $('#donation-add-form').hide 0
  $('#contact-add-form').hide 0

# show and hide the donation form
  $('#donation-cancel-button').click ->
    $('#donation-add-form').slideUp "fast"
    $('#donation-add-button').show 0

  $('#donation-add-button').click ->
    $('#donation-add-form').slideDown "fast"
    $('#donation-add-button').hide 0

# show and hide the contact form
  $('#contact-cancel-button').click ->
    $('#contact-add-form').slideUp "fast"
    $('#contact-add-button').show 0

  $('#contact-add-button').click ->
    $('#contact-add-form').slideDown "fast"
    $('#contact-add-button').hide 0
