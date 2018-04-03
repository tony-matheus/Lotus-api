class Product < ApplicationRecord
    belongs_to :store
    has_one :services_products
end
