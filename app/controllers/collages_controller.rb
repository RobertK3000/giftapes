class CollagesController < ApplicationController
  before_action :set_collage, only: [:show, :edit, :update, :destroy]

  def new
    @collage = Collage.new
    @collage.collage_items.build
  end

  def create
    @collage = Collage.new(collage_params)

    if @collage.save
      Giftape.create(giftable: @collage, user: current_user)
      redirect_to edit_collage_path(@collage,  anchor: "collage-item-#{@collage_item.id}")
    else
      render :new
    end
  end

  def show
  end

  def edit
    @collage_item = CollageItem.new
  end

  def update
    @collage.update(collage_params)
    if @collage.save
      redirect_to edit_collage_path(@collage)
    else
      redirect_to edit_collage_path(@collage)
    end
  end

  def destroy
    @collage.destroy
    redirect_to new_collage_path
  end

  private

  def set_collage
    @collage = Collage.find(params[:id])
  end

  def collage_params
    params.require(:collage).permit(collage_items_attributes:[:prompt, :id, :photo, :collage, :_destroy])
  end
end
