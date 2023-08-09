class TierList < ApplicationRecord
  belongs_to :animation
  belongs_to :user

  validates :tier_score, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1}, presence: true
end
