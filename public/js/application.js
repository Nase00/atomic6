$(document).ready(function() {
  $('.deleteBlogs').click(function(){
    $('.toggle').fadeToggle(50)
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
        $('.toggle').fadeToggle(50)
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
    $('.toggleMakeComment').fadeToggle(50)
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

    toggle.comments();
    
    $('.toggleMakeComment').fadeToggle(50)

    request.done(function(response){
      $('.newContent').show()
      $('.newPostTitle').append(response.title)
      $('.newPostContent').append(response.content)
    });
  })



  // $('.deleteBlogs').click(function(e) {
  //   e.preventDefault()
  //   var request = $.ajax({
  //     url: "/blogs",
  //     method: "get"
  //   })

  //   request.done(function(response){
  //     $('.toggle').fadeToggle(50)
  //   });
  // })
});