class BookingsController < ApplicationController
  before_action :set_travel, only: [:new, :create]

  def new
    @booking = Booking.new
  end

  def create
    @booking = booking.new(booking_params)
    @booking.travel = @travel
    if @booking.save
      redirect_to travel_path(@travel)
    else
      render :new
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:date, :note)
  end

  def set_travel
    @travel = Travel.find(params[:travel_id])
  end
end
