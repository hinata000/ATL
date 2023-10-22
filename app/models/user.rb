class User < ApplicationRecord
  has_many :tier_lists, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_animations, through: :bookmarks, source: :animation
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower
  has_many :active_notifications, class_name: "Notification", foreign_key: "visitor_id", dependent: :destroy
  has_many :passive_notifications, class_name: "Notification", foreign_key: "visited_id", dependent: :destroy

  validates :user_name, presence: true, length: { maximum: 15 }
  VALID_USER_ID_REGEX = /\A[a-z0-9]+$\z/i.freeze
  validates :user_id, presence: true, uniqueness: true, format: { with: VALID_USER_ID_REGEX }, length: { maximum: 15 }
  validates :profile, length: { maximum: 150 }

  mount_uploader :user_image, UserImageUploader
  mount_uploader :header_image, HeaderImageUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  def follow(user)
    followings << user
  end

  def unfollow(user)
    relationships.find_by(followed_id: user.id).destroy
  end

  def following?(user)
    followings.include?(user)
  end

  def bookmarked?(animation)
    bookmark_animations.include?(animation)
  end

  def bookmark(animation)
    bookmark_animations << animation
  end

  def unbookmark(animation)
    bookmark_animations.destroy(animation)
  end

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.confirmed_at = Time.zone.now
      user.user_name = "ゲスト"
      user.user_id = "guest"
    end
  end

  def create_notification_follow!(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? ",current_user.id, id])
    if temp.blank?
      notification = current_user.active_notifications.new(visited_id: id)
      notification.save if notification.valid?
    end
  end
end
