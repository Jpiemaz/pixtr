class DashboardsController < ApplicationController
  def show
    @activites = current_user.activities
  end
end
