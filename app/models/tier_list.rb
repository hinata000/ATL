class TierList < ApplicationRecord
  belongs_to :animation
  belongs_to :user

  after_save :update_tier_average
  after_destroy :update_tier_average

  after_save :update_score
  after_destroy :update_score

  validates :tier_score, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1}, presence: true

  validates :comment, length: { maximum: 500 }

  validates :animation_id, uniqueness: { scope: :user_id }

  def tier_score_change(score)
    if score >= 4.5
      "SS"
    elsif score >= 4
      'S'
    elsif score >= 3
      'A'
    elsif score >= 2
      'B'
    elsif score >= 1
      'C'
    end
  end

  def tier_color(score)
    if score >= 4.5
      'color: #EF4444;'
    elsif score >= 4
      'color: #D97706;'
    elsif score >= 3
      'color: #F59E0B;'
    elsif score >= 2
      'color: #FCD34D;'
    elsif score >= 1
      'color: #10B981;'
    end
  end

  delegate :update_tier_average, to: :animation

  delegate :update_score, to: :animation

  def class_name
    self.class.name
  end
end
