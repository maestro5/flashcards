class Card < ApplicationRecord
  before_validation :capitalize_words
  before_create :set_review_date!

  validates :original_text, :translated_text, presence: true
  validate :words_are_different

  REVIEW_INTERVAL = 3

  scope :random_overdue_cards, -> { where('review_date_on <= ?', Time.current - REVIEW_INTERVAL.days).order("RANDOM()") }

  def review!(translation)
    translation_is_faithful?(translation) && postpone_review_date!
  end

  def translation_is_faithful?(translation)
    translated_text == convert_string(translation)
  end

  def postpone_review_date!
    set_review_date!
    save
  end

  private

  def set_review_date!
    self.review_date_on = REVIEW_INTERVAL.days.since
  end

  def capitalize_words
    self.original_text   = convert_string(original_text)
    self.translated_text = convert_string(translated_text)
  end

  def convert_string(string)
    string.strip.capitalize
  end

  def words_are_different
    return unless original_text == translated_text
    msg = I18n.t('activerecord.errors.models.card.attributes.have_to_be_different')
    errors.add(:original_text, msg)
    errors.add(:translated_text, msg)
  end
end
