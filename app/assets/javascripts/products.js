$(document).on('turbolinks:load', function() {
  if ($('.infinite-scrolling').length > 0) {
    $(window).on('scroll', function() {
      var more_records_url;
      more_records_url = $('.pagination .next_page').attr('href');

      if (more_records_url && $(window).scrollTop() > $(document).height() - $(window).height() - 60) {
        spinner = `
          <div class="spinner-border" role="status">
            <span class="sr-only">Loading...</span>
          </div>
        `
        $('.pagination').html(spinner);
        $.getScript(more_records_url);
      }
    });
  }
});