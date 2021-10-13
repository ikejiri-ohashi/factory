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

  def ensure_normal_user
    return unless resource.email == 'guest@example.com'
      redirect_to root_path, alert: 'ゲストユーザーは削除できません。'
      # redirect_to "https://www.factory-app.com/", alert: 'ゲストユーザーは削除できません。'
  end
end
