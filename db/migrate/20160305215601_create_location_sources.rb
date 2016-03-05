class CreateLocationSources < ActiveRecord::Migration
  def change
    create_table :location_sources do |t|
      t.string :name
      t.string :url

      t.timestamps null: false
    end
  end
end
