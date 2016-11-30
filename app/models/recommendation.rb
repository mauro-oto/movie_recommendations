class Recommendation < ActiveRecord::Base
  belongs_to :user
  belongs_to :movie

  validates_uniqueness_of :user_id, scope: :movie_id
  validates :user_id, :movie_id, presence: true
end
