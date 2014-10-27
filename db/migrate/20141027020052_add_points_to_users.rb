class AddPointsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :points, :int
  end
end
