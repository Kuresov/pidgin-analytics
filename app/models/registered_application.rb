class RegisteredApplication < ActiveRecord::Base
  belongs_to :user
  has_many :events, dependent: :destroy

  validates :name, presence: true, length: { minimum: 5 }
end
