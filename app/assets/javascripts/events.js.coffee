# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('#event_date').datetimepicker
    dateFormat: 'yy-mm-dd'
    timeFormat: 'hh:mm tt'
    controlType: 'select'
    hourMin: 8
    hourMax: 18
    stepMinute: 15
