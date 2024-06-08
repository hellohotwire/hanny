class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :feature

  validates :user_id, uniqueness: { scope: :feature_id }
end
