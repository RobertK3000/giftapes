class MixtapesController < ApplicationController
  def show
    @mixtape = Mixtape.find(params[:id])
  end

  def new
    @mixtape = Mixtape.new
    @mixtape.tracks.build
  end

  def create
    @mixtape = Mixtape.new(mixtape_params)

    if @mixtape.save
      # iterate over the track attributes
      Giftape.create(giftable: @mixtape, user: current_user)
      redirect_to mixtape_path(@mixtape)
    else
      render :new
    end
  end

  def edit
    @mixtape = Mixtape.find(params[:id])
  end

  def update
    @mixtape = Mixtape.find(params[:id])
    @mixtape.update(mixtape_params)
    redirect_to mixtape_path(@mixtape)
  end

  def destroy
    @mixtape = Mixtape.find(params[:id])
    @mixtape.destroy
    redirect_to my_giftapes_path
  end

  private


  def mixtape_params
    params.require(:mixtape).permit(:name, :theme_type, tracks_attributes: [:id, :youtube_url, :start_time, :end_time, :_destroy])
  end

end
