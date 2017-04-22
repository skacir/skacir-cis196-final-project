class Trip < ApplicationRecord
  belongs_to :user

  has_many :trips_users, dependent: :destroy
  has_many :users, through: :trips_users

  validates :transit, inclusion: %w(Walk Car Bus Train)

  validates :available_seats, numericality: { greater_than: -1 }

  def seats_available?
    return true if !available_seats || available_seats > 0
    false
  end
end
