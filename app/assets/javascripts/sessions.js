$(document).ready(function() {
  $('.form-row').on("shown.bs.collapse", function() {
    console.log("im here");
    $("body, html").animate({
            scrollTop: $(this).offset().top
        });
  });
});
