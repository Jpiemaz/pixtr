class FollowingRelationship < ActiveRecord::Base
  belongs_to :followed_user, class_name: "User"
  belongs_to :follower, class_name: "User"

  validates :followed_user_id, uniqueness: { scope: :follower_id }

  validate :cannot_follow_self

  private

  def cannot_follow_self
    if followed_user_id == follower_id
      errors.add(:base, "you can't follow yourself, yo")
    end
  end
end

