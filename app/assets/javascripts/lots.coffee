# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "turbolinks:load", ->
  bin = $('#lot_buy_now_price')
  bin.focus ->
    if(bin.val() == "")
      bin.val(bin.attr('data-default'))
