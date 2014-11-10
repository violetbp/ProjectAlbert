class AddDefaultToUserIdInJob < ActiveRecord::Migration
  def change
    change_column :jobs, :user_id, :integer, :default => 0
  end
end
