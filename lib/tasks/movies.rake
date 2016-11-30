desc "Populate movies from The Movie DB"
task :populate_from_tmdb, [:min_id, :max_id] => :environment do |_, args|
  (args[:min_id]).upto(args[:max_id]) do |i|
    movie = TmdbMovie.find(id: i)
    next if movie.empty? || movie.runtime.nil? || movie.runtime < 45

    movie_in_db = Movie.find_or_create_by(tmdb_id: movie.id)
    movie_in_db.update_attributes(
      title:        movie.name,
      release_date: Date.parse(movie.released),
      tmdb_rating:  movie.rating,
      poster_url:   movie.posters.try(:[], 2).try(:url),
      trailer_url:  movie.trailer || "http://www.apple.com/trailers",
      mpaa_rating:  movie.certification,
      run_time:     movie.runtime,
      imdb_ref:     movie.imdb_id,
      budget:       movie.budget
    )

    actors_in_film = []
    directors_in_film = []
    movie.cast.each do |cast_member|
      if cast_member.job == "Director"
        directors_in_film << cast_member.name
      elsif cast_member.job == "Actor"
        actors_in_film << cast_member.name
      end
    end

    directors_in_film.each do |director|
      movie_in_db.directors << Director.find_or_create_by(name: director)
    end

    3.times do |i|
      movie_in_db.actors << Actor.find_or_create_by(name: actors_in_film[i])
    end

    movie.genres.each do |genre|
      movie_in_db.genres << Genre.find_or_create_by(name: genre.name)
    end

    puts "Added movie #{movie.name}"
    sleep 1
  end
end
