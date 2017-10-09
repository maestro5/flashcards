# frozen_string_literal: true

# --------------------------------------
# Pages controller
# handles routes to pages that do not require CRUD methods
# --------------------------------------
class PagesController < ApplicationController
  def home
    @card = Card.random_overdue_cards.first
  end
end
