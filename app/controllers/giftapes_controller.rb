class GiftapesController < ApplicationController
  def index
    @giftapes = Giftape.where(user: current_user)
  end
end
