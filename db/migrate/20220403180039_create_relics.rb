class CreateRelics < ActiveRecord::Migration[6.1]
  def change
    create_table :relics do |t|
      t.string :device_name
      t.string :device_output

      t.timestamps
    end
  end
end
