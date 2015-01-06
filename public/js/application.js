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

  var newComment = _.template("hello: <%= title %>");

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
    // $('#makeComment').val("Refresh")
    // $('#makeComment').unbind()

    var items = [
      {name:"Alexander", interests:"creating large empires"},
      {name:"Edward", interests:"ha.ckers.org <\nBGSOUND SRC=\"javascript:alert('XSS');\">"},
      {name:"..."},
      {name:"Yolando", interests:"working out"},
      {name:"Zachary", interests:"picking flowers for Angela"}
    ];
    var template = $("#usageList").html();
    $("#target").html(_.template(template,{items:items}));

    request.done(function(response){
      var commentRoute = "/blogs/" + blogId + "/comments/" + response.id

      if ($('.commentsToggle').val().match(/Display Comments: \d*/)) {
        commentToggleBar($('.commentsToggle'))
      }
    });
  })
});

