class RefactorProblemCompletions < ActiveRecord::Migration
  def change
    remove_column :problem_completions, :problemname
    add_column :problem_completions, :problem_id, :int
    remove_column :problem_completions, :username
    add_column :problem_completions, :user_id, :int
  end
end
