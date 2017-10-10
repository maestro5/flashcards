class CardsController < ApplicationController
  before_action :find_card, only: %i(show edit update destroy check)

  CARDS_PER_PAGE = 12

  def index
    @cards = Card.page(params[:page]).per(CARDS_PER_PAGE)
  end

  def new
    @card = Card.new
  end

  def create
    @card = Card.new(card_params)
    if @card.save
      flash[:success] = t 'cards_messages.create_success'
      redirect_to @card
    else
      render :new
    end
  end

  def update
    if @card.update(card_params)
      flash[:success] = t 'cards_messages.update_success'
      redirect_to @card
    else
      render :edit
    end
  end

  def destroy
    @card.destroy
    flash[:success] = t 'cards_messages.destroy_success'
    redirect_to cards_path
  end

  def check
    if @card.review! card_params[:translated_text]
      flash[:success] = t 'cards_messages.translation_success'
      redirect_to root_path
    else
      flash[:error] = t 'cards_messages.translation_wrong'
      render 'pages/home'
    end
  end

  private

  def card_params
    params.require(:card).permit(:original_text, :translated_text)
  end

  def find_card
    @card ||= Card.find(params[:id])
  end
end
