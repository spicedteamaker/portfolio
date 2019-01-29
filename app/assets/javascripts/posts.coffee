$ ->
  if $('.pagination').length && $('#blog-posts').length
    $(window).scroll ->
      url = $('.pagination .next_page').attr('href')
      if url && $(window).scrollTop() > $(document).height() - $(window).height() - 50
        $('.pagination').text("Loading...")
        $.getScript(url)
    $(window).scroll()
