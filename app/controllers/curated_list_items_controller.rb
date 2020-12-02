class CuratedListItemsController < ApplicationController


  def create
  @curated_list = CuratedList.find(params[:curated_list_id])

    @curated_list_item = CuratedListItem.new(curated_list_item_params)
    @curated_list_item.curated_list = @curated_list

    if @curated_list_item.save
      redirect_to curated_list_path(@curated_list)
    else
      render 'curated_lists/show'
    end

  end

  private

  def curated_list_item_params
    params.require(:curated_list_item).permit(:prompt, :url)
  end
end
