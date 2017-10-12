require 'rails_helper'

RSpec.describe Card, type: :model do
  context 'when invalid card' do
    test_values =
      [
        # [original_text, translated_text]
        [' mouSe  ', '  mOusE '],
        ['  КоШКа ', ' кошкА  ']
      ]
    test_values.each do |test_value|
      it "when original_text: #{test_value[0]} and translated_text: #{test_value[1]}" do
        card = Card.new original_text: test_value[0], translated_text: test_value[1]
        error_msg = I18n.t('activerecord.errors.models.card.attributes.have_to_be_different')
        expect(card.save).to be false
        expect(card.errors[:translated_text]).to include error_msg
      end
    end
  end

  context 'when valid card' do
    it "when original text and translated text are different" do
      card = Card.new original_text: ' mouSe  ', translated_text: '  мыШь '
      expect(card.save).to be true
      expect(card.errors).to be_empty
    end
  end

  it '.random_overdue_cards' do
    total_number_of_cards = 10
    number_of_cards_with_expired_review_date = 7

    create_list :card, total_number_of_cards
    Card.take(number_of_cards_with_expired_review_date).each do |card|
      card.update(review_date_on: '20170101'.to_date)
    end
    cards = Card.random_overdue_cards

    expect(cards.count).to eq number_of_cards_with_expired_review_date
    expect(cards).to_not eq Card.random_overdue_cards
  end

  it '#set_next_review_date!' do
    card = Card.create original_text: 'mouse', translated_text: 'мышь'
    card.update(review_date_on: '20170101'.to_date)
    card.set_next_review_date!
    expect(card.review_date_on).to eq((Time.current + Card::REVIEW_INTERVAL.days).to_date)
  end
end
