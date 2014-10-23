class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.belongs_to :problem_completion
      t.belongs_to :problem

      t.string :file_path
      t.integer :problem_id
      t.integer :points
      t.string :time
      
      
      t.timestamps
    end
  end
end
