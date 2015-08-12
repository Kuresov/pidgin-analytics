class RegisteredApplication < ActiveRecord::Base
  has_one :user

  validates :name, presence: true, length: { minimum: 5 }
end
