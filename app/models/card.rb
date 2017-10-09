class Card < ApplicationRecord
  before_validation :capitalize_words
  before_create :add_review_date

  validates :original_text, :translated_text, presence: true
  validate :words_are_different

  scope :random_overdue_cards, -> { where('review_date_on <= ?', Time.current - 3.days).order("RANDOM()") }

  REVIEW_INTERVAL = 3

  def translation_is_faithful?(translation)
    translated_text == multi_lang_capitalize(translation.strip)
  end

  def postpone_review_date
    update_attribute(:review_date_on, REVIEW_INTERVAL.days.since)
  end

  private

  def add_review_date
    self.review_date_on = REVIEW_INTERVAL.days.since
  end

  def capitalize_words
    self.original_text   = multi_lang_capitalize(original_text)
    self.translated_text = multi_lang_capitalize(translated_text)
  end

  def multi_lang_capitalize(string)
    string.mb_chars.capitalize.to_s
  end

  def words_are_different
    return unless original_text == translated_text
    msg = I18n.t('activerecord.errors.models.card.attributes.have_to_be_different')
    errors.add(:original_text, msg)
    errors.add(:translated_text, msg)
  end
end
