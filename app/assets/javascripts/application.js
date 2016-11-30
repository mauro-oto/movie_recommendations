// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require_tree .

$(function() {

  var filledInStar = '\u2605';
  var hollowStar = '☆';

  var hollowStars = function(self) {
    $(self).text(hollowStar);
    $(self).siblings().text(hollowStar);
  };

  var fillStars = function(self) {
    $(self).text(filledInStar);
    $(self).prevAll().text(filledInStar);
  };

  var fillStarsUptoRating = function(self) {
    var rating = $(self).parent().data('current_rating');

    $(self).parent().find('.movie-rating-value').each(function(index) {
      if (index > (rating-1)) {
        return false;
      }
      $(this).text(filledInStar);
    });
  };

  var updateStarsForAll = function($movies) {
    $(document).find('.movie-rating-value').each(function(e) {
      fillStarsUptoRating(this);
    });
  };

  $(".movie-rating-value").on("ajax:success", function(e, data, status, xhr) {
    var self = this;
    var $movieRating = $(this).closest('div.ratings-movie');
    $movieRating.find('.rating').data('current_rating', data.rating_value);

    $movieRating.find('.rating a').each(function(index) {
      var rating_id = data.id;
      var movie_id = $(this).data('movie_id');
      var rating_value = $(this).data('rating_value');
      var new_href = '/ratings/' + rating_id + '?movie_id=' + movie_id + '&rating_value=' + rating_value;
      $(this).attr('href', new_href);
    });

    $movieRating.find('.rating').find('a').attr('data-method', 'put');
    $(this).data('method', 'put');

    hollowStars(this);
    fillStarsUptoRating(this);

  }).on("ajax:error", function(e, xhr, status, error) {
    var $movieRating = $(this).closest('div.ratings-movie');
    var title = $movieRating.find('div.title');
    title.append('<p>Already rated that value.</p>');
    title.find('p').fadeOut(500);
  }).mouseover(function (e) {
    hollowStars(this);
    fillStars(this);
  }).mouseout(function (e) {
    hollowStars(this);
    fillStarsUptoRating(this);
  });

  updateStarsForAll();

});
