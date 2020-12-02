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

      redirect_to mixtape_path(@mixtape)
    else
      render :new
    end
  end

  def mixtape_params
    params.require(:mixtape).permit(:name, :theme_type, tracks_attributes: [:youtube_url, :start_time, :end_time, :_destroy])
  end

end
