$(document).ready(function() {
  $('.deleteBlogs').click(function(){
    $('.toggle').toggle()
  })

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