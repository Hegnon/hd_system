class Profile < ApplicationRecord
  has_many :users

  validates :name, presence: true, uniqueness: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 120 }
end