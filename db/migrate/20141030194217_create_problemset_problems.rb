class CreateProblemsetProblems < ActiveRecord::Migration
  def change
    create_table :problemset_problems do |t|

      t.timestamps
    end
  end
end
