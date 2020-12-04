class CuratedListItemsController < ApplicationController
skip_before_action :verify_authenticity_token

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

  def new
    @curated_list_item = CuratedListItem.new
  end

  def destroy
    @curated_list = CuratedList.new

    @curated_list_item = CuratedListItem.find(params[:id])
    @curated_list_item.destroy
    redirect_to curated_lists_path(@curated_list_item.curated_list)
  end

  private

  def curated_list_item_params
    params.require(:curated_list_item).permit(:prompt, :url)
  end
end
