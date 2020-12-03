class CollageItemsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_collage, only: [:new, :create, :show, :destroy]

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

  def destroy
    @collage_item = CollageItem.find(params[:id])
    @collage_item.destroy

    redirect_to collage_path(@collage)
  end

  private

  def set_collage
    @collage = Collage.find(params[:collage_id])
  end

  def collage_item_params
    params.require(:collage_item).permit(:prompt, :photo)
  end
end
