class Genre < ActiveRecord::Base
  has_many :genres_movies, dependent: :destroy
  has_many :movies, through: :genres_movies

  validates :name, presence: true
end
