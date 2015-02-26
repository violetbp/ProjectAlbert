class FixingSettings < ActiveRecord::Migration
  def change
    drop_table :settings
    add_column :groups, :joincode, :string
    
  end
end
