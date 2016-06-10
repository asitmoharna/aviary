class BirdSerializer < ActiveModel::Serializer
  attributes :id, :name, :family, :continents, :added, :visible

  def id
    object.id.to_s
  end
end
