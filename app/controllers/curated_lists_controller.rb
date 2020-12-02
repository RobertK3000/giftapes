class CuratedListsController < ApplicationController

  def new
    @curated_list = CuratedList.new
  end

  def create

    @curated_list = CuratedList.new(curated_list_params)
    if @curated_list.save
      redirect_to curated_list_path(@curated_list)
    else
      render :new
    end
  end

  def show
    @curated_list = CuratedList.find(params[:id])
    @curated_list_item = CuratedListItem.new
  end

  private

  def curated_list_params
    params.require(:curated_list).permit(:name)
  end
end



