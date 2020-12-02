class CollageItemsController < ApplicationController
  before_action :set_collage, only: [:new, :create, :show]
  def new
    @collage_item = CollageItem.new
  end

  def create
    @collage_item = CollageItem.new(collage_item_params)
    @collage_item.collage = @collage

    if @collage_item.save
      redirect_to collage_path(@collage)
    else
      render :new
    end
  end

  def show
    @collage_item = CollageItem.find(params[:id])
  end

  private

  def set_collage
    @collage = Collage.find(params[:collage_id])
  end

  def collage_item_params
    params.require(:collage_item).permit(:prompt, :photo)
  end
end
