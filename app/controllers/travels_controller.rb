class TravelsController < ApplicationController

  def index
    @travels = policy_scope(Travel.geocoded).order(created_at: :desc).geocoded
    # @travels = Travel # returns flats with coordinates

    @markers = @travels.map do |travel|
      {
        lat: travel.latitude,
        lng: travel.longitude,
        infoWindow: render_to_string(partial: "infowindow", locals: { travel: travel }),
        image_url: helpers.asset_url('logoxtravel.png')
      }
    end
  end

  def show
    @travel = Travel.find(params[:id])
    @booking = Booking.new
    @bookings = @travel.bookings.where(user: current_user)
    authorize @travel
  end

  def new
    @travel = current_user.travels.new
    authorize @travel
  end

  def create
    @travel = Travel.new(travel_params)
    authorize @travel
    @travel.user = current_user
    if @travel.save!
      redirect_to travel_path(@travel)
    else
      render 'new'
    end
  end

  def destroy
    @travel = Travel.find(params[:id])
    authorize @travel
    @travel.destroy
    redirect_to travels_path
  end

  def edit
    @travel = Travel.find(params[:id])
    authorize @travel
  end

  def update
    @travel = Travel.find(params[:id])
    authorize @travel
    @travel.update(travel_params)

    # no need for app/views/travels/update.html.erb
    redirect_to travel_path(@travel)
  end

  private

  def travel_params
    params.require(:travel).permit(:title, :description, :price, :photo)
  end

end
