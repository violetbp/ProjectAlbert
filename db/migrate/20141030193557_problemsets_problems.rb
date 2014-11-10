class ProblemsetsProblems < ActiveRecord::Migration
  def change
    create_table :problemsets_problems do |t|
      t.integer :problemsets_id
      t.integer :problem
    end
  end
end
