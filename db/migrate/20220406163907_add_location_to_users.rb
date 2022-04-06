class AddLocationToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :location, :integer, :default => 88901
  end
end
