class LikeActivity < Activity
  def likable
    subject.likable
  end

  def email
    subject.user.email
  end
end
