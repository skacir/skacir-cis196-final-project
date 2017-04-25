class TripsController < ApplicationController
  before_action :set_trip, only: [:show, :edit, :update, :destroy, :add_user, :delete_user]

  # GET /trips
  # GET /trips.json
  def index
    @upcoming_trips = Trip.where('departure > ?', DateTime.now).order(departure: :asc)
    @previous_trips = Trip.where('departure < ?', DateTime.now).order(departure: :desc)
  end

  # GET /trips/1
  # GET /trips/1.json
  def show
    @driver = User.find(@trip.driver_id) if @trip.driver_id
  end

  # GET /trips/new
  def new
    @trip = Trip.new
  end

  # GET /trips/1/edit
  def edit
    @participants_with_cars = User.where(car: true, id: TripsUser.select("user_id").where(trip_id: @trip.id))
  end

  # POST /trips
  # POST /trips.json
  def create
    @trip = Trip.new(trip_params.merge(user_id: current_user.id))

    respond_to do |format|
      if @trip.save
        format.html { redirect_to @trip, notice: 'Trip was successfully created.' }
        format.json { render :show, status: :created, location: @trip }
      else
        format.html { render :new }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trips/1
  # PATCH/PUT /trips/1.json
  def update
    respond_to do |format|
      if @trip.update(trip_params.merge(user_id: current_user.id))
        format.html { redirect_to @trip, notice: 'Trip was successfully updated.' }
        format.json { render :show, status: :ok, location: @trip }
      else
        format.html { render :edit }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trips/1
  # DELETE /trips/1.json
  def destroy
    @trip.destroy
    respond_to do |format|
      format.html { redirect_to trips_url, notice: 'Trip was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # POST /trips/:id/users
  def add_user
    if @trip.users.include? current_user
      redirect_to @trip, notice: 'User already in trip.'
    else
      @trip.users.append(current_user)
      redirect_to @trip, notice: 'User was successfully added to the trip.'
    end
  end

  # DELETE /trips/:id/users
  def delete_user
    user = TripsUser.find_by(user_id: current_user.id, trip_id: params[:id])
    if user.nil?
      redirect_to @trip, notice: 'User was not in the trip.'
    else
      user.destroy
      redirect_to @trip, notice: 'User was successfully removed from the trip.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trip
      @trip = Trip.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trip_params
      params.require(:trip).permit(:user_id, :driver_id, :departure, :available_seats, :start_location, :end_location, :connection?, :transit, :cost)
    end
end
