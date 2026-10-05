class User < ApplicationRecord
  attr_accessor :password
  before_save :encrypt_password
  validates :password, confirmation: true
  validates :name, presence: true
  validates :email, presence: true
  validates :email, uniqueness: true

  def encrypt_password
    return unless password.present?

    self.password_salt = BCrypt::Engine.generate_salt
    self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
  end

  def self.authenticate(email, password)
    user = find_by(email: email)

    if user &&user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    end
  end
end
