class User < ApplicationRecord
  validates :first_name, :last_name, presence: true
  validates :email, presence: true, uniqueness: true

  enum role: [:admin, :staff, :member]

  validates :role, inclusion: { in: roles.keys }
end
