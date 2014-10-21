class CreateProblemCompletions < ActiveRecord::Migration
  def change
    create_table :problem_completions do |t|
      t.string :username
      t.string :problemname
      t.integer :score
      t.text :previousOutput
      t.integer :attempt

      t.timestamps
    end
  end
end
