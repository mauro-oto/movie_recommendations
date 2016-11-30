class Director < ActiveRecord::Base
  has_many :directors_movies, dependent: :destroy
  has_many :movies, through: :directors_movies

  validates :name, presence: true

  posify { name }
end
