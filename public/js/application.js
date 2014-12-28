$(document).ready(function() {

  var Toggle = function(clickSelector, toggleSelector) {
    clickSelector.click(function(e){
      e.preventDefault()
      toggleSelector.fadeToggle(50)
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
    $('.toggle').fadeToggle(50);
  }

  Toggle($('.deleteBlogs'), $('.toggle'))
  Toggle($('.makeComment'), $('.toggleMakeComment'))

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
    
    $('.toggleMakeComment').fadeToggle(50)

    request.done(function(response){
      CommentToggleBar($('.commentsToggle'))
      $('.newContent').show()
      $('.newPostTitle').append(response.title)
      $('.newPostContent').append(response.content)
    });
  })
});