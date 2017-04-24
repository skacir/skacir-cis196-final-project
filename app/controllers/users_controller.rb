class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :show_trips, :update, :destroy]

  # GET /users
  def index
    @users = User.all
  end

  # GET /users/1
  def show
    #rips = Trip.where('user = ? OR users.user = ?', @user.id, @user.id)
    # @upcoming_trips = Trip.where('(user = ? OR users.user = ?) AND trip.departure > ?', @user.id, @user.id, DateTime.now).order(departure: :asc)
    # prev_trips = TripsUser.where('user = ? AND trip.departure < ?', @user.id, DateTime.now).order(departure: :desc)
    # prev_trips_ids = []
    # prev_trips.each do |id|
    #   prev_trips_ids ++ id[:trip]      
    # end
    # @previous_trips = Trip.find(prev_trips_ids)
    # prev_trips = Trip.where('departure < ?', DateTime.now).order(departure: :desc)
    # prev_trips.keep_if{ |trip| TripsUser.exists?('trip = ? AND user = ?', trip.id, @user.id)}
    # @previous_trips = prev_trips
    # @upcoming_trips = Trip.where('departure > ?', DateTime.now).order(departure: :asc)
  end

  def show_trips
    render :show_trips
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to @user, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    reset_session
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def user_params
    params.require(:user).permit(:name, :car, :number_of_seats, :email, :phone, :password)
  end
end