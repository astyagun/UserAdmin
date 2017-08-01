class User < ApplicationRecord
  ROLES = %w[user admin]

  mount_uploader :avatar, AvatarUploader

  validates :role, inclusion: ROLES
  validates :email, uniqueness: true, format: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  validates :email, :full_name, :birth_date, :small_biography, presence: true
  validates :password, length: {minimum: 8}, allow_nil: true

  has_secure_password

  def admin?
    role == 'admin'
  end
end
