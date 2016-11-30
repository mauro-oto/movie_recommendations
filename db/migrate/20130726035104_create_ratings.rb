class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.belongs_to :movie
      t.belongs_to :user
      t.float :rating_value
      t.boolean :viewable, default: true
      t.timestamps
    end
  end
end
