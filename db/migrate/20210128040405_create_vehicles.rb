class CreateVehicles < ActiveRecord::Migration[5.1]
  def change
    create_table :vehicles do |t|
      t.references :user, foreign_key: true
      t.string :vehicle_type
      t.string :color
      t.string :brand
      t.string :model
      t.integer :max_speed
      t.boolean :air_conditioning
      t.boolean :turbo
      t.boolean :electric

      t.timestamps
    end
  end
end
