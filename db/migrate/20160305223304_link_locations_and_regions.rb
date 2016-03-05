class LinkLocationsAndRegions < ActiveRecord::Migration
  def change
    change_table :locations do |t|
      t.string :address
      t.rename :region, :region_id
    end

    add_foreign_key :locations, :regions
  end
end
