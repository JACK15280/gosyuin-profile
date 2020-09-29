class Notification < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  belongs_to :visitor, class_name: "User", optional: true
  belongs_to :visited, class_name: "User", optional: true
  belongs_to :post, optional: true
  belongs_to :comment, optional: true
  validates :visitor_id, presence: true
  validates :visited_id, presence: true
end
