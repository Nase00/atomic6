$(document).ready(function() {
  var origin = '/blogs/search'
  function clearInput() { $('#input').val(''); }

  function fillResults(input, response) {
    var resultsData = {
      searchedKeyword: input,
      searchedParam: 'title',
      resultBlogs: response
    };

    var route = origin +'?keyword#' + input;
    var resultsTemplate = _.template(
      $('#resultsTemplate').html()
    );

    $('#resultsAnchor').html(resultsTemplate( resultsData ));
    pushQuery(route)
  }

  function noInput(input) {
    var resultsData = { inputKeyword: input };
    var resultsTemplate = _.template(input);
    $('#resultsAnchor').empty()
    $('#resultsAnchor').html(resultsTemplate( resultsData ));
  }

  var keyword = window.location.hash.replace("#","")
  if (keyword) {
    getResults(keyword)
  };

  function getResults(input) {
    var request = $.ajax({
      url: origin + "/" + input,
      method: "get",
      dataType: "json",
      data: 'test'
    })

    request.done(function(response){
      if (response.length != []) {
        fillResults(input, response)
      } else {
        $('#resultsAnchor').html("<p id='error'>No results found for " + "\"" + input + "\"</p>")
      }
    })
  }

  $('#searchButton').click(function (e) {
    e.preventDefault();
    var input = $('#input').val();
    if (input) {
      getResults(input)
    } else {
      noInput("<p id='error'>You didn't enter anything!</p>")
    };
    clearInput();
  })

  $('#cancelSearch').click(function (e) {
    e.preventDefault();
    pushQuery(origin)
    $('#resultsAnchor').empty()
    clearInput();
  })
});
