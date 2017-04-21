class Trip < ApplicationRecord
  belongs_to :user

  has_many :trips_users, dependent: :destroy
  has_many :users, through: :trips_users

  validates :transit, inclusion: %w(Walk Car Bus Train)
end
