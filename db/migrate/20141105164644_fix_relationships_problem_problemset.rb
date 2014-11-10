class FixRelationshipsProblemProblemset < ActiveRecord::Migration
  def change
    create_table :problemsets_problems, id: false do |t|
      t.belongs_to :problem
      t.belongs_to :problemset
    end
  end
end
