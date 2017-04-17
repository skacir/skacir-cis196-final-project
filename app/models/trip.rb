class Trip < ApplicationRecord
  belongs_to :user

  validates :transit, inclusion: %w(Walk Car Bus Train)
end
