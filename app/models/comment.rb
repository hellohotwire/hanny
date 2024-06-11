class Comment < ApplicationRecord
  broadcasts_refreshes_to :feature

  belongs_to :user
  belongs_to :feature

  belongs_to :parent, class_name: "Comment", optional: true
  has_many :replies, class_name: "Comment", foreign_key: :parent_id, dependent: :destroy

  validates :content, presence: true

  MAX_NESTING_LEVEL = 1

  def nesting_level
    parent ? parent.nesting_level + 1 : 0
  end
end
