class ImagesService < ApplicationRecord
  belongs_to :service

  has_attached_file :image,
         :path => ":rails_root/controllers/original/services/:style/:basename.:extension"
end
