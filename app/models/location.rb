class Location < ActiveRecord::Base
  has_and_belongs_to_many :collections
  belongs_to :region
end
