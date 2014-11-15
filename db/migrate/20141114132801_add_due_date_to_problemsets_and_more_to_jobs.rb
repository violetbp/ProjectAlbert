class AddDueDateToProblemsetsAndMoreToJobs < ActiveRecord::Migration
  def change
    add_column :problemsets, :due_date, :string
    add_column :jobs, :style, :integer, :default => 0
    add_column :jobs, :function, :integer, :default => 0
    add_column :jobs, :solution, :integer, :default => 0
  end
end
