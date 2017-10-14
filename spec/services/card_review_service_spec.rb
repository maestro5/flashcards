require 'rails_helper'

RSpec.describe CardReviewService, type: :model do  
  describe '#review!' do
    let(:card) { create :card }

    before { card.update(review_date_on: '20170101'.to_date) }

    it 'does not change the review date when translation is wrong' do
      service = CardReviewService.new card, 'elephant'
      expect { service.review! }.to_not change(card, :review_date_on)
    end

    it 'does change the review date when translation is correct' do
      service = CardReviewService.new card, ' cAt  '
      expect { service.review! }.to change(card, :review_date_on)
    end
  end
end
