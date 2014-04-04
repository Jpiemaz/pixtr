class User < ActiveRecord::Base
  include Clearance::User


  has_many :activities
  has_many :galleries, dependent: :destroy
  has_many :liked_galleries, through: :galleries, source: :likable, source_type: 'Gallery'
  has_many :images, through: :galleries

  has_many :likes, dependent: :destroy
  has_many :liked_images, through: :likes, source: :likable, source_type: 'Image'

  has_many :group_memberships, foreign_key: :member_id, dependent: :destroy
  has_many :groups, through: :group_memberships

  has_many :followed_user_relationships,
    foreign_key: :follower_id,
    class_name: "FollowingRelationship",
    dependent: :destroy

  has_many :followed_users,
    through: :followed_user_relationships

  has_many :follower_relationships,
    foreign_key: :followed_user_id,
    class_name: "FollowingRelationship",
    dependent: :destroy

  has_many :followers,
    through: :follower_relationships

  def notify_followers(subject, target, type)
    if subject.persisted?
      followers.each do |follower|
        follower.activities.create(
          subject: subject,
          type: type,
          actor: self,
          target: target
        )
      # UserMailer.action_email(follower).deliver
      end
    end
  end
  handle_asynchronously :notify_followers

  def upgraded?
    customer_id.present?
  end

  def follow(user)
    follow = followed_user_relationships.create(followed_user: user)
    notify_followers(follow, user, "FollowActivity")
  end

  def following?(user)
    followed_user_ids.include? user.id
  end

  def unfollow(user)
    followed_users.destroy(user)
  end

  def join(group)
    group_membership = group_memberships.create(group: group)
    notify_followers(group_membership, group, "GroupMembershipActivity")
  end

  def leave(group)
    groups.destroy(group)
  end

  def member?(group)
    group_ids.include? group.id
  end

  def like(target)
    like = likes.create(likable: target)
    notify_followers(like, target, "LikeActivity")
  end

  def liked?(target)
    likes.exists?(likable: target)
  end

  def unlike(target)
    like = likes.find_by(likable: target)
    like.destroy
  end
end
