class Customer < ActiveRecord::Base
  attr_accessible :name
  has_many :users, dependent: :destroy
  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
