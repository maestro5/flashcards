require 'rails_helper'

RSpec.describe Card, type: :model do
  let(:overdue_review_date) { '20170101'.to_date }
  let(:error_msg) { I18n.t('activerecord.errors.models.card.attributes.have_to_be_different') }

  # when card is invalid
  it 'invalid with same english original and translated text' do
    card = Card.new original_text: ' mouSe  ', translated_text: '  mOusE '
    card.valid?
    expect(card.errors[:translated_text]).to include error_msg
  end

  it 'invalid with same russian original and translated text' do
    card = Card.new original_text: '  КоШКа ', translated_text: ' кошкА  '
    card.valid?
    expect(card.errors[:translated_text]).to include error_msg
  end

  # when card is valid
  it 'valid with different original and translated text' do
    card = Card.new original_text: ' mouSe  ', translated_text: '  мыШь '
    card.valid?
    expect(card.errors).to be_empty
  end

  # methods
  describe '.random_overdue_cards' do
    let(:total_number_of_cards) { 10 }
    let(:number_of_cards_with_expired_review_date) { 7 }
    let!(:cards) { create_list :card, total_number_of_cards }

    before do
      Card.take(number_of_cards_with_expired_review_date).each do |card|
        card.update(review_date_on: overdue_review_date)
      end
    end

    it 'returns a collection of cards with the overdue date of review' do
      overdue_cards = Card.random_overdue_cards
      expect(overdue_cards.count).to eq number_of_cards_with_expired_review_date
    end

    it 'returns a random sequence of cards' do
      expect(Card.random_overdue_cards).to_not eq Card.random_overdue_cards
    end
  end

  describe '#set_next_review_date!' do
    let(:next_review_date) { (Time.current + Card::REVIEW_INTERVAL.days).to_date }

    it 'sets the next review date' do
      card = Card.create original_text: 'mouse', translated_text: 'мышь'
      card.update(review_date_on: overdue_review_date)
      card.set_next_review_date!
      expect(card.review_date_on).to eq(next_review_date)
    end
  end
end
