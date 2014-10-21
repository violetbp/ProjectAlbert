class CreateProblems < ActiveRecord::Migration
  def change
    create_table :problems do |t|
      t.string :title
      t.text :explanation
      t.text :exIn
      t.text :exOut

      t.timestamps
    end
  end
end
