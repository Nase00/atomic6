// function($) {
// Hmm, I want these to be global functions
// but are they currently polluting the global namespace?

function queryString(variable) {
  var query = window.location.search.substring(1);
  var vars = query.split("&");
  for (var i=0;i<vars.length;i++) {
    var pair = vars[i].split("=");
    if(pair[0] == variable){return pair[1];}
  }
  return pair;
}

function pushQuery(route) {
  window.history.pushState('pushedQuery', 'pushedQuery', route)
}

function toggle(clickSelector, toggleSelector) {
  clickSelector.click(function(e){
    e.preventDefault()
    toggleSelector.slideToggle(50)
  })
}
// }

$(document).ready(function() {
  _.templateSettings = {
    interpolate : /\{\{=(.+?)\}\}/g,
    escape : /\{\{-(.+?)\}\}/g,
    evaluate: /\{\{(.+?)\}\}/g,
  };

  $('#submitPostLink').click(function(e) { // Allows links to redirect to POST data
    e.preventDefault();
    document.postlink.submit();
  });

  toggle($('#deleteBlogs'), $('.toggle'))
});

