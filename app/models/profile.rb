class Profile < ApplicationRecord
  belongs_to :user
  has_many :contacts
  has_many :addresses
end
