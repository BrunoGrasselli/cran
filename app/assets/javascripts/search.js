$(document).ready(function () {
  $('form').bind('submit', function(e) {
    e.preventDefault();
    $("#result").load($(this).attr("action") + "/?query=" + $("#query").val());
  });
});
