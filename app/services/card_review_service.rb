class CardReviewService
  attr_reader :card, :translation

  def initialize(card, translation)
    @card        = card
    @translation = translation.to_s.strip.capitalize
  end

  def review!
    translation_is_faithful? && postpone_review_date!
  end

  private

  def translation_is_faithful?
    card.translated_text == translation
  end

  def postpone_review_date!
    card.set_next_review_date!
    card.save
  end
end
