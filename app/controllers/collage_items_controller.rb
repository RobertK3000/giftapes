class CollageItemsController < ApplicationController
  def new
    @collage = Collage.find(params[:collage_id])
    @collage_item = CollageItem.new
  end
end
