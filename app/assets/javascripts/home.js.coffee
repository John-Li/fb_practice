# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
@HomeCarousel = () ->
  $.ajax
    url: document.location
    data:  ''
    dataType: 'json'
    success: (data, e, t) =>
      parse_data(data)

  parse_data = (data) =>
    defaults =
      photo_template: """
        <li>
          <img src="$photo"/>
        </li>
      """

    for photo in data
      do (photo) =>
        @$photo = $(defaults.photo_template
        .replace("$photo", photo["file"]["url"])).appendTo($("#home-carousel ul"))
    carousel()

  carousel = () =>
    $('#home-carousel > ul').css({left: (( $(window).width() - 1960 ) / 2+$(window).scrollLeft() + "px")})
    $('#home-carousel ul').cycle({
      next: '#home-carousel .arrow-right',
      prev: '#home-carousel .arrow-left',
      height:  '300px',
      fx:     'fade', 
      speed:  'slow',
      pager: '#pager',
      timeout: 5000,
      # callback fn that creates a thumbnail to use as pager anchor 
      pagerAnchorBuilder: (idx, slide) ->
        '<a href="#"><img src="assets/carousel_button.png" width="20" height="20" /></a>'; 
    });
    $(window).resize ->
      $('#home-carousel > ul').css({left: (( $(window).width() - 1960) / 2+$(window).scrollLeft() + "px")})