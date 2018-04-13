class Service < ApplicationRecord
    belongs_to :store

    has_one :services_product
    has_one :services_type
end
