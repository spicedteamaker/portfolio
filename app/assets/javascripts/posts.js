
$(document).on('turbolinks:load', function() {
  $(function() {
    if ($('.pagination').length && $('#blog-posts').length) {
      $(window).scroll(function() {
        const url = $('.pagination .next_page').attr('href');
        if (url && ($(window).scrollTop() > ($(document).height() - $(window).height() - 50))) {
          $('.pagination').text("Loading...");
          return $.getScript(url);
        }
      });
      return $(window).scroll();
    }
  });

  $("#toggle-tags-link").click(function() {
    $(".tag-links-area").toggle();
  });

  $("#toggle-pinned-link").click(function() {
    $(".pinned-posts-area").toggle();
  });
});
