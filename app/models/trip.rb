class Trip < ApplicationRecord
  belongs_to :user

  has_many :trips_users, dependent: :destroy
  has_many :users, through: :trips_users

  validates :transit, inclusion: %w(Walk Car Bus Train)

  validates :available_seats, numericality: { greater_than: -1 }

  validates :driver_id, numericality: { only_integer: true }, :if => :driver_id

  validate :validate_driver_id, :if => :driver_id

  def seats_available?
    return true if !available_seats || available_seats > users.size
    false
  end

  def trip_upcoming?
    departure > DateTime.now
  end

  def future_trip?
    departure > DateTime.now
  end

  private

  def validate_driver_id
    errors.add(:driver_id, "is invalid") unless User.exists?(self.driver_id)
    errors.add(:driver_id, "does not have a car") unless User.exists?(id: driver_id, car: true)
  end
end
