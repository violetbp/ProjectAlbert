class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.int :id
      t.string :file_path
      t.int :problem_id
      
      t.timestamps
    end
  add_index :create_table, :problem_id
  end
end
