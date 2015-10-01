class Bucketlist < ActiveRecord::Base
  has_many :items, :dependent => :destroy
  belongs_to :user
  validates :name, presence: true, length: { minimum: 1 }
end
