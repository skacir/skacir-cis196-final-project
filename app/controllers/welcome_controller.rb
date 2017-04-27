class WelcomeController < ApplicationController
  def index
    return unless logged_in?
    trips = current_user.all_trips
    @upcoming_trips =
      trips.where('departure > ?', DateTime.now).order(departure: :asc)
  end
end
