class RecommendationsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_ratings!

  def index
    @recommendations = current_user.unrated_recommendations
                                   .includes(:movie)
                                   .shuffle
  end

end
