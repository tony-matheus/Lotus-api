class Address < ApplicationRecord
    belongs_to :user
    belongs_to :store, optional: true
end
