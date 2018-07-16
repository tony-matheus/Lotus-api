class Service < ApplicationRecord
    belongs_to :store

    has_one :services_product, dependent: :destroy
    has_one :services_type, dependent: :destroy
end
