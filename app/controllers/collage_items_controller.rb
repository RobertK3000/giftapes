class CollageItemsController < ApplicationController
  before_action :set_collage, only: [:new, :create]
  def new
    @collage_item = CollageItem.new
  end

  def create
    @collage_item = CollageItem.new()
    @collage_item.collage = @collage
    # if @collage.save

    # else

    # end
  end

  private

  def set_collage
    @collage = Collage.find(params[:collage_id])
  end
end
