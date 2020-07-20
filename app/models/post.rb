class Post < ApplicationRecord
  validates :image, :title, presence: true
  mount_uploader :image, ImageUploader

  belongs_to :user
  has_many :group_posts, dependent: :destroy
  has_many :groups, through: :group_posts, dependent: :destroy
end
