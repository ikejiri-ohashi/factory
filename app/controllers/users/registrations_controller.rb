class Users::RegistrationsController < Devise::RegistrationsController
  before_action :ensure_normal_user, only: :destroy

  def after_sign_up_path_for(resource)
    "https://www.factory-app.com/"
  end

  def after_update_path_for(resource)
    "https://www.factory-app.com/"
  end

  def ensure_normal_user
    if resource.email == 'guest@example.com'
      redirect_to "https://www.factory-app.com/", alert: 'ゲストユーザーは削除できません。'
    end
  end

end