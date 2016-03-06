class LinkCollectionsAndUsers < ActiveRecord::Migration
  def change
    add_foreign_key :collections, :users
  end
end
