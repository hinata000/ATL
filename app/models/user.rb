class User < ApplicationRecord
  has_many :tier_lists, dependent: :destroy
  has_many :tier_list_entiers, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_animations, through: :bookmarks, source: :animation
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower
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
      user.confirmed_at = Time.now
      user.user_name = "ゲスト"
      user.user_id = "guest"
    end
  end
end
