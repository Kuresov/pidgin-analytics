class User < ActiveRecord::Base
  attr_accessor :password
  has_many :registered_applications, dependent: :destroy
  before_save :encrypt_password

  validates :email, presence: true, uniqueness: true,
    format: { with: /(@)\w+\./, message: 'Email address is not valid.' }
  validates :password, confirmation: true, presence: true, length: { minimum: 5 }

  def self.authenticate(email, password)
    user = User.find_by(email: email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
end
