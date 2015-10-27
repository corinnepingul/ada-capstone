$(document).ready(function() {
  $('.form-row').on("shown.bs.collapse", function() {
    $("body, html").animate({
            scrollTop: $(this).offset().top
        });
  });
});
