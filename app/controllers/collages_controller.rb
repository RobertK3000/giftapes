class CollagesController < ApplicationController
  def new
    @collage = Collage.new
    @collage.collage_items.build
  end

  def create
    @collage = Collage.new
    if @collage.save
      redirect_to collage_path(@collage)
    else
      render :new
    end
  end

  def show
    @collage = Collage.find(params[:id])
    @collage_item = CollageItem.new
  end

  private
  def collage_params
    params.require(:collage).permit(collage_items_attributes:[:prompt, :photo, :collage])
  end
end
