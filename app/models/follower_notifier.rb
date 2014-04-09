class FollowerNotifier
  def initialize(user)
    @user = user
  end

  def notify(subject, target, type)
    user.followers.each do |follower|
      follower.activities.create(
        subject: subject,
        actor: user,
        target: target,
        type: type
      )
      # UserMailer.action_email(follower).deliver
    end
  end
  # handle_asynchronously :notify

  private
  attr_reader :user
end
