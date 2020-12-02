class CollagesController < ApplicationController
  def new
    @collage = Collage.new
  end

  def create
    @collage = Collage.new
    # if @collage.save

    # else

    # end
  end

  def show
    @collage = Collage.find(params[:id])
  end

end
