class Collection < ActiveRecord::Base
  belongs_to :user
  has_many :locations
  has_many :likes
end
