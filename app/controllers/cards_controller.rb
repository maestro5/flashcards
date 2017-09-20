class CardsController < ApplicationController
  before_action :find_card, only: %i[show edit update destroy]

  CARDS_PER_PAGE = 12

  def index
    @cards = Card.page(params[:page]).per(CARDS_PER_PAGE)
  end

  def new
    @card = Card.new
  end

  def create
    @service = CardCreateService.(params: params)
    @card = @service.card
    if @service.success?
      flash[:success] = t 'cards_messages.create_success'
      redirect_to @card
    else
      render json: @service.errors.errors_storage
    end
  end

  def update
    @service = CardUpdateService.(params: params)
    @card = @service.card
    if @service.success?
      flash[:success] = t 'cards_messages.update_success'
      redirect_to @card
    else
      render json: @service.errors.errors_storage
    end
  end

  def destroy
    @card.destroy
    flash[:success] = t 'cards_messages.destroy_success'
    redirect_to cards_path
  end

  private

  def find_card
    @card ||= Card.find(params[:id])
  end
end
