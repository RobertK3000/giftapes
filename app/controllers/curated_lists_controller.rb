class CuratedListsController < ApplicationController

  def new
    @curated_list = CuratedList.new
  end

  def create

    @curated_list = CuratedList.new(curated_list_params)
    if @curated_list.save
      redirect_to curated_list_path(@curated_list)
      Giftape.create(giftable: @curated_list, user: current_user)
    else
      render :new
    end
  end

  def show
    @curated_list = CuratedList.find(params[:id])
    @curated_list_item = CuratedListItem.new
  end

  def destroy

    @curated_list = CuratedList.find(params[:id])
    @curated_list.destroy
    redirect_to my_giftapes_path

    # respond_to do |format|
    #   format.html { redirect_to curated_lists_path, notice: 'Item was removed.' }
    # end



  end

  private

  def curated_list_params
    params.require(:curated_list).permit(:name)
  end
end



