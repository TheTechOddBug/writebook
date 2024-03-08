class User < ApplicationRecord
  include Avatar, Role

  has_many :sessions, dependent: :destroy
  has_secure_password validations: false

  scope :active, -> { where(active: true) }

  def initials
    name.scan(/\b\w/).join
  end
end
