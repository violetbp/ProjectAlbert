class AddDataStorageToProblems < ActiveRecord::Migration
  def change
    add_column :problems, :active_probs, :string, :default => ""
    add_column :problems, :extra_probs, :string, :default => ""
    add_column :problems, :grading_type, :string, :default => ""

  end
end
