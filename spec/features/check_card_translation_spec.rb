require 'rails_helper'

feature 'Visitor can translate the card', %q{
  As a visitor
  I able to translate the card
} do

  given!(:card) { create :card }
  given(:invalid_translation_text) { 'mouse' }
  given(:valid_translation_text) { 'cat' }
  given(:overdue_review_date) { '20170101'.to_date }

  before do
    card.update_attribute(:review_date_on, overdue_review_date)
    visit root_path
  end

  scenario 'overdue card present on home page' do
    expect(page).to have_content "#{I18n.t('card_panel.show_title')} #{card.id}"
  end

  scenario 'card original text present on home page' do
    expect(page).to have_field('card[original_text]', with: card.original_text)
  end

  context 'when translation is invalid' do
    before do
      fill_in 'card[translated_text]', with: invalid_translation_text
      find('[name=commit]').click
    end

    scenario 'does not postpone the review date' do
      expect(card.reload.review_date_on).to eq(overdue_review_date)
    end

    scenario 'return the error message', js: true do
      expect(page).to have_content(I18n.t('cards_messages.translation_wrong'))
    end
  end # when translation is invalid

  context 'when translation is valid' do
    before do
      fill_in 'card[translated_text]', with: valid_translation_text
      find('[name=commit]').click
    end

    scenario 'postpone the card review date' do
      expect(card.reload.review_date_on).not_to eq(overdue_review_date)
    end

    scenario 'redirect to home page' do
      expect(current_path).to eq(root_path)
    end

    scenario 'return the success message', js: true do
      expect(page).to have_content(I18n.t('cards_messages.translation_success'))
    end
  end # when translation is valid
end # Visitor can translate the card
