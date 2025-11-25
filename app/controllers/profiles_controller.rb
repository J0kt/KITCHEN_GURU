class ProfilesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:edit]

  before_action :set_profile, only: [:edit, :update]

  def edit
  end

  def update
    if @profile.update(profile_params)
      redirect_to meal_plans_generate_path, notice: "Profile updated successfully!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_profile
    if current_user.nil?
      redirect_to new_user_session_path, alert: "Please sign in to continue your profile setup."
      return 
    end

    @profile = current_user.profile
  end

  def profile_params
    params.require(:profile).permit(
      :gender,
      :age,
      :activity_level,
      :weekly_budget_max,
      :max_prep_time_minutes,
      :allergies
    )
  end
end
