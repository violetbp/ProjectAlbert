class ChangeUsers < ActiveRecord::Migration
  def change
    remove_column :users, :points
    add_column :users, :image, :string
    add_column :users, :about, :text
    add_column :users, :grade, :int

  end
end
