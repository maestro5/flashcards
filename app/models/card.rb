class Card < ApplicationRecord
  before_validation :capitalize_words
  before_create :set_next_review_date!

  validates :original_text, :translated_text, presence: true
  validate :words_are_different

  REVIEW_INTERVAL = 3

  scope :random_overdue_cards, -> { where('review_date_on <= ?', Time.current - REVIEW_INTERVAL.days).order("RANDOM()") }

  def set_next_review_date!
    self.review_date_on = REVIEW_INTERVAL.days.since
  end

  private

  def capitalize_words
    self.original_text   = original_text.to_s.strip.capitalize
    self.translated_text = translated_text.to_s.strip.capitalize
  end

  def words_are_different
    return unless original_text == translated_text
    msg = I18n.t('activerecord.errors.models.card.attributes.have_to_be_different')
    errors.add(:original_text, msg)
    errors.add(:translated_text, msg)
  end
end
