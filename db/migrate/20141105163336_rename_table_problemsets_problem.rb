class RenameTableProblemsetsProblem < ActiveRecord::Migration
  def change
     drop_table :problemsets_problems
   
  end
end
