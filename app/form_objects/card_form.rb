class CardForm
  include Virtus.model

  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attribute :id, String
  attribute :original_text, String
  attribute :translated_text, String
  attribute :review_date_on, String

  validates :original_text, :translated_text, :review_date_on, presence: true
  validate :words_are_different

  attr_reader :card

  def save
    valid? ? persist! : @card = Card.new(attributes)
  end

  def update
    @card = Card.find(attributes[:id])
    valid? ? @card.update(attributes) : @card
  end

  private

  def words_are_different
    return unless original_text == translated_text
    msg = I18n.t('activemodel.errors.models.card_form.attributes.have_to_be_different')
    errors.add(:original_text, msg)
    errors.add(:translated_text, msg)
  end

  def persist!
    @card = Card.create!(attributes)
  end
end
