class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :title
      t.text :explanation
      t.string :teacher
      
      t.timestamps
    end
    create_table :groups_problemsets, id: false do |t|
      t.belongs_to :group
      t.belongs_to :problemset
    end
    create_table :groups_users, id: false do |t|
      t.belongs_to :group
      t.belongs_to :user
    end
    
  end
end
