class ApplicationController < ActionController::Base
  protect_from_forgery

  def get_ratings!
    @ratings = current_user.ratings
    @ratings_movie_ids = @ratings.pluck(:movie_id)
    @rating_values = {}
    current_user.ratings.each do |rating|
      @rating_values[rating.movie_id] = rating.rating_value
    end
  end

end
