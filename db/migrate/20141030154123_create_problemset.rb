class CreateProblemset < ActiveRecord::Migration
  def change
    create_table :problemsets do |t|
      t.string :title
      t.text :explanation
      t.timestamps
      
    end
  end
end
