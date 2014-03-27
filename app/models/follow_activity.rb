class FollowActivity < Activity
  def email
    subject.followed_user.email
  end
end
