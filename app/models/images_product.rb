class ImagesProduct < ApplicationRecord
  belongs_to :product

  has_attached_file :image,
         :path => ":rails_root/controllers/original/products/:style/:basename.:extension"
end
