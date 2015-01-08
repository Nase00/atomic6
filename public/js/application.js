$(document).ready(function() {

  _.templateSettings = {
    interpolate : /\{\{=(.+?)\}\}/g,
    escape : /\{\{-(.+?)\}\}/g,
    evaluate: /\{\{(.+?)\}\}/g,
  };

  $('#submitPostLink').click(function(e) { // Allows Register link to redirect to POST data
    e.preventDefault();
    document.postlink.submit();
  });
});

