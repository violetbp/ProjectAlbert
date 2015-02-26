class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string :title
      t.string :adminpass
      
      t.timestamps
    end
  end
end
