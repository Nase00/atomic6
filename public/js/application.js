$(document).ready(function() {
  $('.deleteBlogs').click(function(){
    $('.toggle').toggle()
  })

  // Fuck this is messy and not DRY
  
  toggle = {
    comments: function comments() {
      $('.commentsToggle').click(function(){
        if($(this).val().match(/Display Comments: \d*/)) {
          var value = $(this).val()
          value = value.replace("Display Comments:", "Hide Comments:")
        } else {
          var value = $(this).val()
          value = value.replace("Hide Comments:", "Display Comments:")
        };
        $(this).val(value)
        $('.toggle').toggle()
      })
    }
  }
  
  toggle.comments();

  $('.makeComment').click(function(e){
    e.preventDefault()
    if($('.commentsToggle').val().match(/Hide Comments: \d*/)) {
      var value = $('.commentsToggle').val()
      value = value.replace("Hide Comments:", "Display Comments:")
    };
    $('.toggleMakeComment').toggle()
  })

  $('#submitComment').click(function(e) {
    e.preventDefault()
    var id = 25
    console.log(e)
    var request = $.ajax({
      url: "/blogs/" + id + "/comments",
      method: "post",
      dataType: "json",
      data: $("#commentForm").serialize()
    })

    if($('.commentsToggle').val().match(/Display Comments: \d*/)) {
      var value = $('.commentsToggle').val()
      value = value.replace("Display Comments:", "Hide Comments:")
    };
    $('.toggleMakeComment').toggle()
    $('.commentsToggle').val(value)
    $('.toggle').show()

    request.done(function(response){
      console.log(response)
      $('.newPostTitle').append(response.title)
      $('.newPostContent').append(response.content)

      // var commenter = function(response.commenter_id) {
      //   return 'User.find(' + response.commenter_id + ')';
      // }
      $('.newPostAuthor').append(response.commenter_id)
    });
  })



  // $('.deleteBlogs').click(function(e) {
  //   e.preventDefault()
  //   var request = $.ajax({
  //     url: "/blogs",
  //     method: "get"
  //   })

  //   request.done(function(response){
  //     $('.toggle').toggle()
  //   });
  // })
});