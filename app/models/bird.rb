class Bird
  include Mongoid::Document

  field :name, type: String
  field :family, type: String
  field :continents, type: Array, default: []
  field :added, type: String
  field :visible, type: Mongoid::Boolean

  validates :name, :family, presence: true
  validates :continents, presence: true,
                         length: { minimum: 1 }

  scope :visible, -> { where visible: true }
end
