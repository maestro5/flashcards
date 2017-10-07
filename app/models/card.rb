class Card < ApplicationRecord
  before_validation :capitalize_words
  before_create :add_review_date

  validates :original_text, :translated_text, presence: true
  validate :words_are_different

  private

  def capitalize_words
    self.original_text   = original_text.mb_chars.capitalize.to_s
    self.translated_text = translated_text.mb_chars.capitalize.to_s
  end

  def add_review_date
    self.review_date_on = 3.days.since
  end

  def words_are_different
    return unless original_text == translated_text
    msg = I18n.t('activerecord.errors.models.card.attributes.have_to_be_different')
    errors.add(:original_text, msg)
    errors.add(:translated_text, msg)
  end
end
