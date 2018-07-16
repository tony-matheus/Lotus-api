class Contact < ApplicationRecord
  belongs_to :profile
  belongs_to :store
end
