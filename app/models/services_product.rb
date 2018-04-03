class ServicesProduct < ApplicationRecord
    belongs_to :service
    belongs_to :product
end
