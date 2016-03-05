class Location < ActiveRecord::Base
  has_one :location_types
end
