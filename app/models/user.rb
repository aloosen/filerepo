class User < ActiveRecord::Base
  attr_accessible :email, :fullname, :name, :password
  has_secure_password

  before_save { |user| user.name = user.name.downcase }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_PASSWORD = /.*(?=[A-Z])(?=.*[a-z])(?=.*[0-9])/
  validates :name, presence: true, length: { maximum: 16 }, uniqueness: { case_sensitive: false }
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  validates :fullname, presence: true
  validates :password, presence: true, format: { with: VALID_PASSWORD}, length: { minimum: 6 }
end
