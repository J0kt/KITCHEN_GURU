class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile, only: [:show, :edit, :update]

  def new
    @profile = current_user.build_profile
  end

  def create
    @profile = current_user.build_profile(profile_params)
    if @profile.save
      redirect_to who_you_are_path, notice: "Profile created successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    # Affiche le profil actuel
  end

  def edit
    # Formulaire "Who you are"
  end

  def update
    if @profile.update(profile_params)
      redirect_to who_you_are_path, notice: "Profile updated successfully!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_profile
    @profile = current_user.profile || current_user.build_profile
  end

  def profile_params
    params.require(:profile).permit(:gender, :age, :activity_level)
  end
end
