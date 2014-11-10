class DropTableProblemsetProblems < ActiveRecord::Migration
  def change
    drop_table :problemset_problems
  end
end
