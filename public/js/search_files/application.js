var query_string = function (variable) {
  var query = window.location.search.substring(1);
  var vars = query.split("&");
  for (var i=0;i<vars.length;i++) {
    var pair = vars[i].split("=");
    if(pair[0] == variable){return pair[1];}
  }
  return pair;
}

var Toggle = function(clickSelector, toggleSelector) {
  clickSelector.click(function(e){
    e.preventDefault()
    toggleSelector.slideToggle(50)
  })
}

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
});

