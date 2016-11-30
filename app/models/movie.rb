class Movie < ActiveRecord::Base
  has_many :ratings, dependent: :destroy
  has_many :users, through: :ratings

  has_many :actors_movies, dependent: :destroy
  has_many :actors, through: :actors_movies

  has_many :genres_movies, dependent: :destroy
  has_many :genres, through: :genres_movies

  has_many :directors_movies, dependent: :destroy
  has_many :directors, through: :directors_movies

  has_many :recommendations, dependent: :destroy
  has_many :users, through: :recommendations

  posify { title }
end
