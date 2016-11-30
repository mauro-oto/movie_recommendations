class RatingsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_ratings!

  def index
    @movies = Movie.where(demo_display: true).sample(24)
  end

  def create
    rating = current_user.ratings.build(rating_params)

    if rating.save
      UpdateRecommendationsWorker.perform_async(rating.id)
      render json: rating
    else
      render json: rating.errors
    end
  end

  def update
    rating = current_user.ratings.find(params[:id])
    rating.rating_value = params[:rating_value]

    if rating.save
      UpdateRecommendationsWorker.perform_async(rating.id)
      render json: rating
    else
      flash[:notice] = "Your rating was not updated."
      render json: rating.errors
    end
  end

  def search
    result = Pose.search(params[:query], [Movie, Actor, Director], limit: 20)
    query_match = params[:query].downcase
    result[Actor].each do |actor|
      if actor.name.downcase == query_match
        @actor_movies = actor.movies
      end
    end

    result[Director].each do |director|
      if director.name.downcase == query_match
        @director_movies = director.movies
      end
    end

    @movies = result[Movie]
  end

  private

  def rating_params
    { movie_id: params[:movie_id].to_i,
      rating_value: params[:rating_value].to_i }
  end
end
