class AddIndexToRatings < ActiveRecord::Migration
  def change
    add_index :ratings, :movie_id
    add_index :ratings, :rating_value
    add_index :ratings, :user_id
  end
end
