class UpdateRecommendationsWorker
  include Sidekiq::Worker

  def perform(rating_id)
    rating = Rating.where(id: rating_id).first
    RecommendationSystem.new(rating).update_recommendations
  end

end
