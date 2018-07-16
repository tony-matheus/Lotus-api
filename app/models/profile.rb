class Profile < ApplicationRecord
  has_one :user, dependent: :destroy
  has_many :contacts, dependent: :destroy
  has_many :addresses, dependent: :destroy
end
