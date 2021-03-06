class User < ApplicationRecord
  has_many :tasks, dependent: :destroy


  validates_presence_of :username, :email, unless: :guest?
  validates_uniqueness_of :username, allow_blank: true
  validates_confirmation_of :password

  has_secure_password validations: false

  def self.new_guest
    new { |u| u.guest = true }
  end

  def name
    guest ? "Guest" : username
  end

  def move_to(user)
    tasks.update_all(user_id: user.id)
  end
end
