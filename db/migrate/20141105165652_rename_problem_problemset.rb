class RenameProblemProblemset < ActiveRecord::Migration
  
    def self.up
      rename_table :problemsets_problems, :problems_problemsets
  end

   def self.down
      rename_table :problems_problemsets, :problemsets_problems
  end
end
