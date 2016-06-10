class Bird
  include Mongoid::Document

  field :name, type: String
  field :family, type: String
  field :continents, type: Array, default: []
  field :added, type: String, default: ->{ Time.zone.now.strftime("%Y-%m-%d") }
  field :visible, type: Mongoid::Boolean, default: false

  validates :name, :family, :added, presence: true
  validates :continents, presence: true,
                         length: { minimum: 1 }
  validate :unique_continents
  validate :added_date_format

  scope :visible, -> { where visible: true }

  before_save :ensure_correct_added_date_format

  private

  def unique_continents
    return unless continents.present?
    errors[:continents] = 'need unique values' unless continents.uniq.length == continents.length
  end

  def added_date_format
    return unless added.present?
    date = Date.parse(added) rescue nil
    errors[:added] = 'please enter a valid date' unless date.present?
  end

  # This ensures the format of the added date is always "YYYY-mm-dd" format.
  # Specifically helpful, when the entered date is valid e.g. June 10, 2016
  def ensure_correct_added_date_format
    date = Date.parse(added) rescue nil
    self.added = date.strftime("%Y-%m-%d") if date.present?
  end
end
