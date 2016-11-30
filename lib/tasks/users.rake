desc "Creates two default users with default ratings"
task seed_users: :environment do
  user = User.find_or_create_by(email: "mauro.otonelli@gmail.com",
                                password: "password",
                                password_confirmation: "password")

  user_2 = User.find_or_create_by(email: "pepe@example.com",
                                  password: "password",
                                  password_confirmation: "password")

  fight_club =    Movie.where(title: "Fight Club").first.id
  pulp_fiction =  Movie.where(title: "Pulp Fiction").first.id
  the_godfather = Movie.where(title: "The Godfather").first.id
  forrest_gump =  Movie.where(title: "Forrest Gump").first.id
  inception =     Movie.where(title: "Inception").first.id
  titanic =       Movie.where(title: "Titanic").first.id
  scary_movie =   Movie.where(title: "Scary Movie").first.id

  rating_1 = Rating.create(movie_id: fight_club, rating_value: 5)
  user.ratings << rating_1
  RecommendationSystem.new(rating_1).update_recommendations

  rating_2 = Rating.create(movie_id: pulp_fiction, rating_value: 5)
  user.ratings << rating_2
  RecommendationSystem.new(rating_2).update_recommendations

  rating_3 = Rating.create(movie_id: the_godfather, rating_value: 5)
  user.ratings << rating_3
  RecommendationSystem.new(rating_3).update_recommendations

  rating_4 = Rating.create(movie_id: forrest_gump, rating_value: 3)
  user.ratings << rating_4
  RecommendationSystem.new(rating_4).update_recommendations

  rating_5 = Rating.create(movie_id: inception, rating_value: 4)
  user.ratings << rating_5
  RecommendationSystem.new(rating_5).update_recommendations

  rating_6 = Rating.create(movie_id: titanic, rating_value: 3)
  user.ratings << rating_6
  RecommendationSystem.new(rating_6).update_recommendations

  rating_7 = Rating.create(movie_id: fight_club, rating_value: 4)
  user_2.ratings << rating_7
  RecommendationSystem.new(rating_7).update_recommendations

  rating_8 = Rating.create(movie_id: pulp_fiction, rating_value: 5)
  user_2.ratings << rating_8
  RecommendationSystem.new(rating_8).update_recommendations

  rating_9 = Rating.create(movie_id: the_godfather, rating_value: 5)
  user_2.ratings << rating_9
  RecommendationSystem.new(rating_9).update_recommendations

  rating_10 = Rating.create(movie_id: forrest_gump, rating_value: 5)
  user_2.ratings << rating_10
  RecommendationSystem.new(rating_10).update_recommendations

  rating_11 = Rating.create(movie_id: inception, rating_value: 5)
  user_2.ratings << rating_11
  RecommendationSystem.new(rating_11).update_recommendations

  rating_12 = Rating.create(movie_id: scary_movie, rating_value: 3)
  user_2.ratings << rating_12
  RecommendationSystem.new(rating_12).update_recommendations
end
