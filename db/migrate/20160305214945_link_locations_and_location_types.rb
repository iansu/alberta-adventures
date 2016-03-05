class LinkLocationsAndLocationTypes < ActiveRecord::Migration
  def change
    change_table :locations do |t|
      t.integer :location_type_id
    end

    add_foreign_key :locations, :location_types
  end
end
