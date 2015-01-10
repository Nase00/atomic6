$(document).ready(function() {
  var origin = '/blogs/search'
  var keyword = window.location.hash.replace("#","")
  if (keyword) {
    getResults(keyword)
  };

  function clearInput() {
    $('#input').val('');
    $('#resultsAnchor').empty()
    pushQuery(origin)
  }

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

  $('#searchButton').click(function (e) {
    e.preventDefault();
    var input = $('#input').val();
    clearInput();
    if (input) {
      getResults(input)
    } else {
      $('#resultsAnchor').html("<p id='error'>You didn't enter anything!</p>")
    };
  })

  $('#cancelSearch').click(function (e) {
    e.preventDefault();
    clearInput();
  })
});
