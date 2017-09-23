class CardCreateService < ApplicationService
  attr_reader :card

  def initialize(params:)
    @params = params
    super
  end

  private

  def executing
    capitalize_words && add_review_date && create_card
  end

  def capitalize_words
    @params[:card][:original_text]   = @params[:card][:original_text].mb_chars.capitalize.to_s
    @params[:card][:translated_text] = @params[:card][:translated_text].mb_chars.capitalize.to_s
    true
  end

  def add_review_date
    @params[:card][:review_date_on] = 3.days.since
    !@params[:card][:review_date_on].nil?
  end

  def create_card
    card_form = CardForm.new(card_params)
    card_form.valid? || @errors[:card] = card_form.errors.messages
    card_form.save
    @card = card_form.card
    @card.persisted?
  end

  def card_params
    @params.require(:card).permit(:original_text, :translated_text, :review_date_on)
  end
end
