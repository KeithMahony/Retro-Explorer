class AddUserIdToRelics < ActiveRecord::Migration[6.1]
  def change
    add_column :relics, :user_id, :integer
    add_index :relics, :user_id
  end
end
