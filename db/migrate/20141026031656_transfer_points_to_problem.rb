class TransferPointsToProblem < ActiveRecord::Migration
  def change
    remove_column :jobs, :points
    add_column :problems, :points, :int
  end
end
