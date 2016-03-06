class AddPictureToCollections < ActiveRecord::Migration
  def change
    change_table :collections do |t|
      t.string :collection_img
    end
  end
end
