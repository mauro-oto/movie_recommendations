class RecommendationSystem

  attr_reader :current_user, :rated_movie, :rating_value, :already_rated_ids

  def initialize(rating)
    @current_user      = rating.user
    @rating_value      = rating.rating_value.to_i
    @rated_movie       = Movie.find(rating.movie_id)
    @already_rated_ids = @current_user.ratings.pluck(:movie_id)
  end

  def update_recommendations
    return if rating_value < 3
    recommendations_from_closest_user = []

    if closest_user
      movies_to_rec = movies_from_closest_user
      recommendations_from_closest_user = create_recommendations(movies_to_rec)
    end

    newly_rated_movie_cluster = unit_cluster(recommendations_from_closest_user)

    # TODO: Hacer que esto sea el mismo metodo que create_recommendations.
    #
    # Hacer que create_recommendations tome otro parametro, que va a ser
    # si la recomendacion es colaborativa o por contenido, que va a vivir en una
    # columna nueva bajo la tabla de recomendaciones.
    #
    # Hacer que la recomendacion tenga otra columna nueva que va a ser un dato,
    # el mail de la persona con la cual tenes el gusto en comun, si la rec fuese
    # colaborativa, o la pelicula que origino la recomendacion si la rec es por
    # contenido.
    newly_rated_movie_cluster.each do |new_movie|
      current_user.recommendations.create(movie_id: new_movie)
    end
  end

  def create_recommendations(movie_ids)
    movie_ids = movie_ids[0..collaborative_limit]
    movie_ids.each { |id| current_user.recommendations.create(movie_id: id) }
  end

  def unit_cluster(total_recs = [])
    directors = rated_movie.directors
    actors    = rated_movie.actors
    genres    = rated_movie.genres

    directors_movies = entity_recommendation_list(directors, Director)
    actors_movies    = entity_recommendation_list(actors, Actor)
    genres_movies    = entity_recommendation_list(genres, Genre)

    actor_director_genre_recs = directors_movies & actors_movies & genres_movies
    actor_director_recs       = directors_movies & actors_movies
    director_genre_recs       = directors_movies & genres_movies
    actor_genre_recs          = genres_movies & actors_movies

    populate_recommendation_list(actor_director_genre_recs, total_recs)
    populate_recommendation_list(actor_director_recs, total_recs)
    populate_recommendation_list(director_genre_recs, total_recs)
    populate_recommendation_list(actor_genre_recs, total_recs)
    populate_recommendation_list(directors_movies, total_recs)
    populate_recommendation_list(actors_movies, total_recs)
    populate_recommendation_list(genres_movies, total_recs)

    total_recs.uniq
  end

  # Adds movies from clustering to recommendation list
  # (there is a limit to the amount of movies added based on rating value
  # of the target movie)
  def populate_recommendation_list(chosen_list, total_recs)
    return if recommendation_limit_reached?(total_recs)

    chosen_list.each do |movie_id|
      break if recommendation_limit_reached?(total_recs)
      next if movie_id == rated_movie.id

      total_recs << movie_id unless already_rated_ids.include? movie_id
    end
  end

  private

  def collaborative_limit
    RECOMMENDATION_LIMITS[rating_value] * 0.6
  end

  def entity_recommendation_list(entities, klass)
    entities.map do |entity|
      klass.where(id: entity.id).includes(:movies).first.movies.pluck(:id)
    end.flatten
  end

  def movies_from_closest_user
    closest_user.ratings
                .where("ratings.rating_value >= 3")
                .where("ratings.movie_id not in (?)", already_rated_ids)
                .pluck(:movie_id)
  end

  def recommendation_limit_reached?(total_recs)
    total_recs.length >= RECOMMENDATION_LIMITS[rating_value]
  end

  def closest_user
    @closest_user ||= current_user.closest_user
  end
end
