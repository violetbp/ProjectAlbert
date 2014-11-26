class AddSubmissionStatusToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :submitted, :boolean, :default => false
    
  end
end
