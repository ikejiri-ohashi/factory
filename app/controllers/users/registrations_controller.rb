class Users::RegistrationsController < Devise::RegistrationsController
  before_action :ensure_normal_user, only: :destroy

  def after_sign_up_path_for(_resource)
    root_path
    # "https://www.factory-app.com/"
  end

  def after_update_path_for(_resource)
    root_path
    # "https://www.factory-app.com/"
  end
  
end
