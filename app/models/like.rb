class Like < ActiveRecord::Base
  belongs_to :user
  has_many :collections
end
