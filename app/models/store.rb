class Store < ApplicationRecord
    has_many :services
    has_many :addresses
    has_many :contacts
    has_many :products
    
end
