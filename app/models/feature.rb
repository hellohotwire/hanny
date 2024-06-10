class Feature < ApplicationRecord
  belongs_to :user
  has_many :votes, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :voters, through: :votes, source: :user

  enum status: { open: 0, in_progress: 1, done: 2}

  def self.status_options
    [['Oldest', 'old'], ['Newest', 'new']] + statuses.keys.map { |key| [key.to_s.humanize.titleize, key] }
  end
end
