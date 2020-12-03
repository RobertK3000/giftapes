class CollagesController < ApplicationController
  def new
    @collage = Collage.new
    @collage.collage_items.build
  end

  def create
    @collage = Collage.new(collage_params)
    if @collage.save
      Giftape.create(giftable: @collage, user: current_user)
      redirect_to edit_collage_path(@collage)
    else
      render :new
    end
  end

  def show
    @collage = Collage.find(params[:id])
    @collage_item = CollageItem.new
  end

  def edit
    @collage = Collage.find(params[:id])
    @collage_item = CollageItem.new
  end

  def update
    @collage = Collage.find(params[:id])
    @collage.update(collage_params)
    raise
    @collage.save!
    if @collage.save
      redirect_to collage_path(@collage)
    else
      redirect_to edit_collage_path(@collage)
    end
  end

  private
  def collage_params
    params.require(:collage).permit(collage_items_attributes:[:prompt, :photo, :collage])
  end
end
