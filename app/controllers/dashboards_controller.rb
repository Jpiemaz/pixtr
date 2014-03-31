class DashboardsController < ApplicationController
  def show
    @activites = current_user.activities.includes(:actor, :target, :subject)
  end
end
