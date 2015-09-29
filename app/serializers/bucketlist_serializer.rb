class BucketlistSerializer < ActiveModel::Serializer
  attributes :id, :name, :created_at
  has_many :items
end
