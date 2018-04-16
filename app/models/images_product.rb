class ImagesProduct < ApplicationRecord
  belongs_to :product
  has_attached_file :image, styles: {large: "600x600", medium: "300x300", thumb: "150x150#"}
  validates_attachment :image, content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }

  # has_attached_file :image,
  #        :path => ":rails_root/controllers/original/products/:style/:basename.:extension"
end
