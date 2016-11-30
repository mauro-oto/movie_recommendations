class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.integer :rt_id
      t.integer :tmdb_id
      t.string :imdb_ref
      t.integer :tmdb_rating
      t.date :release_date
      t.string :critic_consensus
      t.integer :rt_score
      t.string :poster_url
      t.string :trailer_url
      t.string :mpaa_rating
      t.integer :run_time
      t.integer :budget
      t.timestamps
    end
  end
end
