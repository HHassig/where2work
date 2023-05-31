class VenuesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @venues = Venue.all
    @venues = @venues.has_plugs if params[:has_plugs].present?
    @venues = @venues.has_calls if params[:has_calls].present?
    @venues = @venues.has_light if params[:has_light].present?
    @venues = @venues.has_wifi if params[:has_wifi].present?
    if params[:search].present?
      sql_query = <<~SQL
        venues.category @@ :query
        OR venues.name @@ :query
        OR venues.address @@ :query
      SQL
      @search_term = params[:search]
      @venues = @venues.where(sql_query, query: "%#{@search_term}%")
    end
    @markers = @venues.geocoded.map do |venue|
      { lat: venue.latitude, lng: venue.longitude,
        info_window: render_to_string(partial: "info_window", locals: { venue: }) }
    end
  end

  def new
    @venue = Venue.new
  end

  def create
    @venue = Venue.new(venue_params)
    @venue.user = current_user
    if @venue.save
      redirect_to venue_path(@venue), notice: 'Venue was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @venue = Venue.find(params[:id])
    @markers = [{ lat: @venue.latitude, lng: @venue.longitude }]
    @booking = Booking.new
    @venues = Venue.all
  end

  private

  def venue_params
    params.require(:venue).permit(:user_id, :category, :name, :address, :website, :power_outlets, :natural_light,
                                  :suited_for_calls, :opening_time, :closing_time, :wifi, :photo)
  end
end
