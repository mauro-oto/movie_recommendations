class Rating < ActiveRecord::Base
  belongs_to :movie
  belongs_to :user

  validates_uniqueness_of :user_id, scope: :movie_id
  validates :movie_id, :user_id, :rating_value, presence: true

  validates :rating_value, numericality: {
    greater_than_or_equal_to: 1, less_than_or_equal_to: 5
  }

  attr_accessible :movie_id, :rating_value
end
