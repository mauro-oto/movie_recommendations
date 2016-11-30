class AddDemoColumn < ActiveRecord::Migration
  def change
    add_column :movies, :demo_display, :boolean
  end
end
