class Post < ApplicationRecord
  validates :image, :title, presence: true
  mount_uploader :image, ImageUploader

  belongs_to :user
  has_many :comments
  has_many :group_posts, dependent: :destroy
  has_many :groups, through: :group_posts, dependent: :destroy

  def self.search(search)
    if search
      Post.where(['title LIKE ? OR content LIKE ?', "%#{search}%", "%#{search}%"])
    else
      Post.all
    end
  end
end
