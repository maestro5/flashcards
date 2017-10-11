require 'rails_helper'

RSpec.describe CardReviewService, type: :model do
  let(:card) { create :card }

  context '#review!' do
    it 'when translation is invalid' do
      service = CardReviewService.new card, 'elephant'
      card.update(review_date_on: '20170101'.to_date)
      expect { service.review! }.to_not change(card, :review_date_on)
    end

    it 'when translation is valid' do
      service = CardReviewService.new card, ' cAt  '
      card.update(review_date_on: '20170101'.to_date)
      expect { service.review! }.to change(card, :review_date_on)
    end
  end # review!

  it '#translation_is_faithful?' do
    expect(CardReviewService.new(card, 'elephant').translation_is_faithful?).to be false
    expect(CardReviewService.new(card, 'cat').translation_is_faithful?).to be true
  end
end
