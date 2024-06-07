class User < ApplicationRecord
  belongs_to :profile

  enum status: { ativo: 0, bloqueado: 1, desativado: 2 }

  validates :email, presence: true, uniqueness: true, length: { maximum: 60 }
  validates :password_digest, presence: true
  validates :name, presence: true, length: { maximum: 50 }
  validates :profile, presence: true
  validates :status, presence: true, inclusion: { in: statuses.keys }

  has_secure_password
end