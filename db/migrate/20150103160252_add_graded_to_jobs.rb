class AddGradedToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :graded, :boolean, :default => false
  end
end
