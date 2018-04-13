class ImagesStore < ApplicationRecord
  belongs_to :store

  validates_attachment :image,
                     content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }

  has_attached_file :image,
         :path => ":rails_root/controllers/original/stores/:style/:basename.:extension"
end
