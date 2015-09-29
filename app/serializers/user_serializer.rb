class UserSerializer < ActiveModel::Serializer
   attributes :id, :email, :token, :created_at
  has_many :bucketlists
end
