class TravelsController < ApplicationController

  def index
    @travels = Travel.all
  end

  def show
    @travel = Travel.find(params[:id])
  end

  def new
    @travel = Travel.new
  end

  def create
    @travel = Travel.new(travel_params)
    @travel.user = current_user
    if @travel.save!
      redirect_to travel_path(@travel)
    else
      render 'new'
    end
  end

  private

  def travel_params
    params.require(:travel).permit(:title, :description, :price)
  end

end
