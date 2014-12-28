$(document).ready(function() {

  var Toggle = function(clickSelector, toggleSelector) {
    clickSelector.click(function(e){
      e.preventDefault()
      toggleSelector.slideToggle(50)
    })
  }

  var CommentToggleBar = function(toggle) {
    if (toggle.val().match(/Display Comments: \d*/)) {
      var value = toggle.val()
      value = value.replace("Display Comments:", "Hide Comments:")
    } else {
      var value = toggle.val()
      value = value.replace("Hide Comments:", "Display Comments:")
    };
    toggle.val(value)
    $('.toggle').slideToggle(50);
  }

  function query_string(variable)
  {
     var query = window.location.search.substring(1);
     var vars = query.split("&");
     for (var i=0;i<vars.length;i++) {
             var pair = vars[i].split("=");
             if(pair[0] == variable){return pair[1];}
     }
     return(false);
  }

  Toggle($('.deleteBlogs'), $('.toggle'))
  Toggle($('.makeComment'), $('.toggleMakeComment'))

  if (query_string('display_comments')) {
    CommentToggleBar($('.commentsToggle'))
  }
  $('.commentsToggle').click(function(e) {
    e.preventDefault()
    CommentToggleBar($('.commentsToggle'))
  })

  $('#submitComment').click(function(e) {
    e.preventDefault()
    var url = ("/blogs/" + $(e.currentTarget).attr("dir") + "/comments");
    console.log(url);
    var request = $.ajax({
      url: "/blogs/" + $(e.currentTarget).attr("dir") + "/comments",
      method: "post",
      dataType: "json",
      data: $("#commentForm").serialize()
    })

    $('.toggleMakeComment').slideToggle(50)


    request.done(function(response){
      if ($('.commentsToggle').val().match(/Display Comments: \d*/)) {
        CommentToggleBar($('.commentsToggle'))
      }
      $('.newContent').show()
      $('.newCommentTitle').append(response.title)
      $('.newCommentContent').append(response.content)
    });
  })
});