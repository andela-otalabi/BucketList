class Item < ActiveRecord::Base
  belongs_to :bucketlist
  validates :name, presence: true, length: { minimum: 1 }
end
