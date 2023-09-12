class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :animation

  validates :user_id, uniqueness: { scope: :animation_id }
end
