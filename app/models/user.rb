class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          #:confirmable,
          :omniauthable

  include DeviseTokenAuth::Concerns::User

  has_one :profile
  
  has_many :contacts
  has_many :addresses
end
