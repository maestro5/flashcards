require 'rails_helper'

RSpec.describe CardReviewService, type: :model do  
  describe '#review!' do
    let(:card) { create :card }

    before { card.update(review_date_on: '20170101'.to_date) }

    it 'failure with wrong translation' do
      service = CardReviewService.new card, 'elephant'
      expect { service.review! }.to_not change(card, :review_date_on)
    end

    it 'successfully with correct translation' do
      service = CardReviewService.new card, ' cAt  '
      expect { service.review! }.to change(card, :review_date_on)
    end
  end
end
