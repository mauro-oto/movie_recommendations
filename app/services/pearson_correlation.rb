# Calculates the distance between two users. The pearson correlation coefficient
class PearsonCorrelation

  attr_reader :user_ratings, :user_rating_average,
              :other_user_ratings, :other_user_rating_average

  def initialize(user, other_user)
    @user_ratings = user.movie_rating_pairs
    @other_user_ratings = other_user.movie_rating_pairs
    @user_rating_average = rating_average(user_ratings)
    @other_user_rating_average = rating_average(other_user_ratings)
  end

  def calculate
    return 0 if shared_movie_ids.empty?

    deviation / denominator
  end

  private

  def denominator
    Math.sqrt(square_of_user_ratings * square_of_other_user_ratings).to_f
  end

  def deviation
    shared_movie_ids.inject(0) do |sum, movie_id|
      target = user_ratings[movie_id] - user_rating_average
      other = other_user_ratings[movie_id] - other_user_rating_average
      sum + (target * other)
    end.to_f
  end

  def rating_average(ratings)
    user_rating_sum = ratings.values.sum
    return 0 if shared_movie_ids.size.zero?
    user_rating_sum / shared_movie_ids.size
  end

  def shared_movie_ids
    @shared_movie_ids ||= user_ratings.keys & other_user_ratings.keys
  end

  def square_of(ratings, average)
    shared_movie_ids.inject(0) do |sum, movie_id|
      sum + ((ratings[movie_id] - average) ** 2)
    end
  end

  def square_of_user_ratings
    square_of(user_ratings, user_rating_average)
  end

  def square_of_other_user_ratings
    square_of(other_user_ratings, other_user_rating_average)
  end
end
