class Post < ApplicationRecord
  validates :image, :title, presence: true
  mount_uploader :image, ImageUploader
end
