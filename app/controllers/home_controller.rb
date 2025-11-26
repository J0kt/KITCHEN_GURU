class HomeController < ApplicationController
  def index
    if user_signed_in?
      redirect_to new_profile_path and return unless current_user.profile_completed?

      redirect_to dashboard_path
    end
  end
end
