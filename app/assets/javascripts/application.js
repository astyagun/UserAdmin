// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require turbolinks
//= require jquery
//
// See which files are available in Bootstrap: https://github.com/twbs/bootstrap-rubygem/blob/latest-release/assets/javascripts/bootstrap-sprockets.js
//= require bootstrap/util
//= require bootstrap/alert
//= require popper
//= require bootstrap/tooltip
//
//= require bootstrap-datepicker/core
//= require_tree .

// Registration page
$(document).on('turbolinks:load', function() {
  $('.form-group.user_birth_date input').datepicker({
    'format': 'yyyy-mm-dd',
    'autoclose': true,
    'defaultViewDate': {'year': (new Date().getFullYear() - 20)},
    'endDate': (new Date().getFullYear() - 5) + '-12-31',
    'startView': 'decades'
  });

  $('abbr[title]').tooltip();
});
