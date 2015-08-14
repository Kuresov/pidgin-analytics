class RegisteredApplication < ActiveRecord::Base
  belongs_to :user
  has_many :events

  validates :name, presence: true, length: { minimum: 5 }
end
