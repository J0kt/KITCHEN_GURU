class Users::RegistrationsController < Devise::RegistrationsController

  def create
    super do |resource|
      if resource.persisted?
        return respond_with resource, location: after_sign_up_path_for(resource), status: :see_other
      end
    end
  end

  protected

  def after_sign_up_path_for(resource)
    who_you_are_path
  end
end
