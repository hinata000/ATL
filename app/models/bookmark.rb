class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :animation, counter_cache: :bookmarks_count

  validates :user_id, uniqueness: { scope: :animation_id }

  def self.ransackable_attributes(auth_object = nil)
    ["animation_id"]
  end
end
