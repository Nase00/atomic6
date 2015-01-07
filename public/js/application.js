$(document).ready(function() {

  _.templateSettings = {
    interpolate : /\{\{=(.+?)\}\}/g,
    escape : /\{\{-(.+?)\}\}/g,
    evaluate: /\{\{(.+?)\}\}/g,
  };

  var Toggle = function(clickSelector, toggleSelector) {
    clickSelector.click(function(e){
      e.preventDefault()
      toggleSelector.slideToggle(50)
    })
  }

  var commentToggleBar = function(toggle) {
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

  Toggle($('#deleteBlogs'), $('.toggle'))
  Toggle($('#makeComment'), $('.toggleMakeComment'))

  if (query_string('display_comments')) {
    commentToggleBar($('.commentsToggle'))
  }
  $('.commentsToggle').click(function(e) {
    e.preventDefault()
    commentToggleBar($('.commentsToggle'))
  })

  var commentTemplate = _.template(
    $('#commentTemplate').html()
  );

  $('#submitComment').click(function(e) {
    e.preventDefault()
    var blogId = $(e.currentTarget).attr("dir")
    var url = ("/blogs/" + blogId + "/comments");
    console.log(url);
    var request = $.ajax({
      url: "/blogs/" + blogId + "/comments",
      method: "post",
      dataType: "json",
      data: $("#commentForm").serialize()
    })

    $('.toggleMakeComment').slideToggle(50)
    $('#noComments').fadeToggle(50)

    request.done(function(response){
      var commentRoute = "/blogs/" + blogId + "/comments/" + response.id

      if ($('.commentsToggle').val().match(/Display Comments: \d*/)) {
        commentToggleBar($('.commentsToggle'))
      }

      var response_time = new Date(response.created_at).strftime("on %m/%d/%Y at %I:%M%p")

      var commentData = {
        newCommentId: response.id,
        newCommentTitle: response.title,
        newCommentContent: response.html_content,
        newCommentCommenterId: response.commenter_id,
        newCommentTime: response_time
      }

      $('#commentTemplate').after(commentTemplate( commentData ));
    });
  })
});

