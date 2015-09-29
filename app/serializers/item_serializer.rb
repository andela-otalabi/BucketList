class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :done, :date_created, :date_modified

  def date_created
    "#{object.created_at}"
  end

  def date_modified
    "#{object.updated_at}"
  end

end
