class User < ApplicationRecord
  belongs_to :profile

  validates :email, presence: true, uniqueness: true, length: { maximum: 60 }
  validates :password_digest, presence: true
  validates :name, presence: true, length: { maximum: 50 }
  validates :status, presence: true
end