class CreateActorsMovies < ActiveRecord::Migration
  def change
    create_table :actors_movies do |t|
      t.belongs_to :movie
      t.belongs_to :actor
      t.timestamps
    end
  end
end
