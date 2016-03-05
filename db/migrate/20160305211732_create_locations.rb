class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.string :description
      t.decimal :lat, precision: 20, scale: 16
      t.decimal :long, precision: 20, scale: 16
      t.integer :region

      t.timestamps null: false
    end
  end
end
