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
end
