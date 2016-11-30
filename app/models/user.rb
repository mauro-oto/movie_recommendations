class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :password_confirmation, :name, :email, :password

  has_many :ratings, dependent: :destroy
  has_many :movies, through: :ratings

  has_many :recommendations, dependent: :destroy
  has_many :movies, through: :recommendations

  def unrated_recommendations
    recommendations.where.not(movie_id: ratings.pluck(:movie_id))
  end

  # Find the user's closest user using PearsonCorrelation
  def closest_user
    users = User.includes(ratings: :movie)

    result = [users.first.id, pearson_correlation(users.first)]

    users.each do |user|
      next if user.id == self.id
      current_pearson_correlation = pearson_correlation(user)

      if (1 - current_pearson_correlation).abs < (1 - result.last).abs
        result = [user, current_pearson_correlation]
      end
    end
    result[1] == 0 ? nil : result[0]
  end

  def movie_rating_pairs
    ratings.pluck(:movie_id, :rating_value).to_h
  end

  private

  def pearson_correlation(other_user)
    PearsonCorrelation.new(self, other_user).calculate
  end
end
