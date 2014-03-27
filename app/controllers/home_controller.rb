class HomeController < ApplicationController
  before_action :goto_dashboard

  def index
  end

  def goto_dashboard
    if signed_in?
      redirect_to dashboard_path
    end
  end
end
