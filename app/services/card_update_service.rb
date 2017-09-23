class CardUpdateService < ApplicationService
  attr_reader :card

  def initialize(params:)
    @params = params
    super
  end

  private

  def executing
    capitalize_words && update_card
  end

  def capitalize_words
    @params[:card][:original_text]   = @params[:card][:original_text].mb_chars.capitalize.to_s
    @params[:card][:translated_text] = @params[:card][:translated_text].mb_chars.capitalize.to_s
    true
  end

  def update_card
    @params[:card][:id] = @params[:id]
    card_form = CardForm.new(card_params)
    card_form.valid? || @errors[:card] = card_form.errors.messages
    card_form.update
    @card = card_form.card
    @errors.empty?
  end

  def card_params
    @params.require(:card).permit(:id, :original_text, :translated_text, :review_date_on)
  end
end
