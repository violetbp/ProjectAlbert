class AddPointsToJob < ActiveRecord::Migration
  def change
    add_column :jobs, :points, :int, :default => 1, null: false
    change_column_null :jobs, :points, 1
  end
end
