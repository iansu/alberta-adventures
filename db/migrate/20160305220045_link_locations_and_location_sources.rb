class LinkLocationsAndLocationSources < ActiveRecord::Migration
  def change
    change_table :locations do |t|
      t.integer :location_source_id
    end

    add_foreign_key :locations, :location_sources
  end
end
