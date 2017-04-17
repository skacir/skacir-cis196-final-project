require 'bcrypt'

class User < ActiveRecord::Base

  include BCrypt
  validates :name, presence: true
  validates :name, uniqueness: true
  validates :name, length: { minimum: 2 }
  validates :name, format: { with: /\A[A-Z].*/, message: 'must start with a capital letter' }

  validates :email, presence: true

  has_many :trips, dependent: :destroy

  def password
    @password ||= Password.new(password_hash) unless password_hash.nil?
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
end
