class Location < ActiveRecord::Base
  has_one :location_types
  has_one :location_source
end
