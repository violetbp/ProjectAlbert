class ChangePointsInJobs < ActiveRecord::Migration
  def change
    rename_column :jobs, :points, :autopoints
  end
end
