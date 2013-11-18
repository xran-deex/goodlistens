class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    if current_user.name == nil
      more_info_path  
    else
        new_user_path
    end
  end
end