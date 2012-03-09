jQuery ($) ->
  $('.promo img').delay(500).each (index) ->
    $(this).delay(500*index).fadeIn(400)