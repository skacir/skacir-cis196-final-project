require 'bcrypt'

class User < ActiveRecord::Base

  include BCrypt
  validates :name, presence: true
  validates :name, uniqueness: true
  validates :name, length: { minimum: 2 }
  validates :name, format: { with: /\A[A-Z].*/, message: 'must start with a capital letter' }

  validates :email, presence: true
  validates :email, uniqueness: true
  validates :email, format: { with: /.@.\..*/, message: 'must be in the format username@website.tld' }

  validates :number_of_seats, numericality: { greater_than: 0 }, :if => :car
  validates_presence_of :number_of_seats, :if => :car

  has_many :trips, dependent: :destroy #, :order => 'departure ASC'

  def password
    @password ||= Password.new(password_hash) unless password_hash.nil?
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
end
