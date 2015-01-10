$(document).ready(function() {
  var commentToggleBar = (function(toggle) {
    if (toggle.val().match(/Display Comments: \d*/)) {
      var value = toggle.val();
      value = value.replace("Display Comments:", "Hide Comments:");
    } else {
      var value = toggle.val();
      value = value.replace("Hide Comments:", "Display Comments:");
    };
    toggle.val(value);
    $('.toggle').slideToggle(50);
  })

  function displayErrors(validation_errors) {
    $('.toggleMakeComment').slideToggle(50)
    $('#error').html(validation_errors)
  };

  toggle($('#makeComment'), $('.toggleMakeComment'))

  if (queryString('display_comments') === "true") {
    commentToggleBar($('.commentsToggle'))
  }

  $('#toggleAllComments').click(function(e) {
    e.preventDefault()
    commentToggleBar($('#toggleAllComments'))
  })

  var commentTemplate = _.template(
    $('#commentTemplate').html()
  );

  $('#submitComment').click(function(e) {
    e.preventDefault()
    var blogId = $(e.currentTarget).attr("dir")
    var url = ("/blogs/" + blogId + "/comments");
    var request = $.ajax({
      url: "/blogs/" + blogId + "/comments",
      method: "post",
      dataType: "json",
      data: $("#commentForm").serialize()
    })

    pushQuery(url)
    $('.toggleMakeComment').slideToggle(50)
    $('#noComments').fadeToggle(50)

    request.done(function(response){
      if (response.validation_errors) {
        displayErrors(response.validation_errors)
      } else {
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
      }
    });
  })
});

