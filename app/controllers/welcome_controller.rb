class WelcomeController < ApplicationController
  def index
    if logged_in?
      trips = current_user.get_all_trips
      @upcoming_trips = trips.where('departure > ?', DateTime.now).order(departure: :asc)
      # @previous_trips = trips.where('departure < ?', DateTime.now).order(departure: :desc)
    end
  end
end
