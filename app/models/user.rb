class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          #:confirmable,
          :omniauthable

  include DeviseTokenAuth::Concerns::User

  belongs_to :profile

  has_attached_file :avatar, styles: {large: "600x600", medium: "300x300", thumb: "150x150#"}
  validates_attachment :avatar, content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }

end
