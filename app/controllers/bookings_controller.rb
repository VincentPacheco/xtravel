class BookingsController < ApplicationController
  before_action :set_travel, only: [:new, :create]

  def index
    @bookings = policy_scope(Booking).order(created_at: :desc)
  end

  def show
    @booking = Booking.find(params[:id])
    authorize @booking
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.travel = @travel
    authorize @booking
    @booking.user = current_user
    if @booking.save
      redirect_to bookings_path
    else
      render "travels/show"
      # flash.alert = "Date already taken!"
    end

    # if @booking.exists?(date)
    #   render "travels/show"
    #   flash.alert = "Date already taken!"
    # else
    #   if @booking.save
    #     redirect_to travel_path(@travel)
    #   else
    #     render "travels/show"
    #   end
    # end
  end

  def destroy
    @booking = Booking.find(params[:id])
    authorize @booking
    @booking.destroy
    redirect_to bookings_path
  end

  private

  def booking_params
    params.require(:booking).permit(:date, :note)
  end

  def set_travel
    @travel = Travel.find(params[:travel_id])
  end
end
