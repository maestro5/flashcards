class CardsController < ApplicationController
  def index
    @cards = Card.page(params[:page]).per(12)
  end
end
