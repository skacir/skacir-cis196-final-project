class Trip < ApplicationRecord
  belongs_to :user

  has_many :trips_users, dependent: :destroy
  has_many :users, through: :trips_users

  validates :transit, inclusion: %w(Walk Car Bus Train)

  validates :available_seats, numericality: { greater_than: -1 }

  def seats_available?
    return true if !available_seats || available_seats > users.size
    false
  end

  def trip_upcoming?
    departure > DateTime.now
  end

  def add_driver(driver_to_add)
    car ? driver = driver_to_add : self.error.add('Cannot add driver - trip is not by car')
  end

  def future_trip?
    departure > DateTime.now
  end
end
