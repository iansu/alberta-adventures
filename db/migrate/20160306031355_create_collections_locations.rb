class CreateCollectionsLocations < ActiveRecord::Migration
  def change
    create_table :collections_locations, id: false do |t|
      t.belongs_to :collection, index: true
      t.belongs_to :location, index: true
      t.timestamps null: false
    end
  end
end
