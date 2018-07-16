class Store < ApplicationRecord
    has_many :services, dependent: :destroy
    has_many :addresses, dependent: :destroy
    has_many :contacts, dependent: :destroy
    has_many :products, dependent: :destroy
    
end
