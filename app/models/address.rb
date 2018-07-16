class Address < ApplicationRecord
    belongs_to :profile
    belongs_to :store, optional: true
end
