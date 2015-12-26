#= require jquery
#= require jquery.turbolinks
#= require jquery_ujs
#= require turbolinks
#= require moment
#= require moment/ja.js
#= require bootstrap
#= require bootstrap-datetimepicker
#= require_tree .

$ ->
  $(".datetimepicker").datetimepicker({
    locale: 'ja'
  })
