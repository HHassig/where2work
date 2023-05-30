class BookingsController < ApplicationController
  before_action :set_booking, only: :show
  before_action :set_venue, only: %i[:show :new :create :destroy]
  # fow now we don't need to set any venue before starting a method

  def index
    # @bookings = Booking.all
    @venues = Venue.all
    @user_bookings = Booking.where(user_id: current_user.id)
  end

  def show
    @booking = Booking.find(params[:id])
    @user_bookings = Booking.where(user_id: current_user.id)
    @user_id = @booking.user_id
    @user = User.find(@user_id)
  end

  def new
    @venues = Venue.all
    @booking = Booking.new
  end

  def create
    set_venue
    @booking = Booking.new
    @booking.venue = @venue
    @booking.user = current_user
    @booking.date = params[:booking]["date"]
    if @booking.save
      redirect_to booking_path(@booking)
    else
      redirect_to new_user_session_path
    end
  end

  def edit
    @booking = Booking.find(params[:id])
  end

  def update
    @booking = Booking.find(params[:id])
    if @booking.update(booking_params)
      redirect_to booking_path(@booking)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to bookings_path, status: :see_other
  end

  private

  def booking_params
    params.require(:booking).permit(:date)
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def set_venue
    @venue = Venue.find(params[:venue_id])
  end
end
