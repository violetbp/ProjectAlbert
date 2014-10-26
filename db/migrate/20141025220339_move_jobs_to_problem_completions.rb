class MoveJobsToProblemCompletions < ActiveRecord::Migration
  def change
    add_column :jobs, :previous_output, :text
    add_column :jobs, :attempt, :integer
    add_reference :jobs, :user
    remove_column :jobs, :problem_completion_id
  end
end