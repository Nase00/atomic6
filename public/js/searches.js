$(document).ready(function() {
  var keyword = query_string(keyword);

  $('#searchButton').click(function (e) {
    e.preventDefault();

    var input = $('#input').val();
    var resultsTemplate = _.template(
      $('#resultsTemplate').html()
    );

    var route = '/blogs/search?keyword=' + $('input').val();
    window.history.pushState('searchResults', 'Search Results', route);

    var resultsData = {
      inputKeyword: input
    };

    $('#resultsAnchor').html(resultsTemplate( resultsData ));
  })
});
