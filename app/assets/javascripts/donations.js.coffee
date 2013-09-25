# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#console.log 'foo'
#$('#donation_amount').keyup (e) ->
#  $('.stripe-button').data('amount', $(e.currentTarget).val() * 100)

$('#donate_button').click (e) ->
  email = $('#donation_email').val()
  amount = parseInt($('#donation_amount').val().replace(/[^\d.-]/g, ''))

  if !email || email.indexOf("@") == -1
    alert('Please enter a valid email address. This is where we will send your donation receipt.')
    return

  unless _.isNumber(amount) && amount >= 5 && amount <= 5000
    alert('Please enter a donation amount between 5 and 5000.')
    return

  $('#donation_amount').val(amount)

  token = (res) ->
    $input = $('<input type=hidden name=stripeToken />').val(res.id)
    $('#donation-form').append($input).submit()

  StripeCheckout.open
    key:         $('#stripe-data').data('key')
    amount:      amount*100
    currency:    'usd'
    name:        'Piano Project'
    description: 'Donations'
    panelLabel:  'Donate'
    image: $('#stripe-data').data('image')
    token:       token