class User < ApplicationRecord
  validates :role, inclusion: %w[user admin]
  validates :email, format: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  validates :email, :full_name, :birth_date, :small_biography, presence: true
end
