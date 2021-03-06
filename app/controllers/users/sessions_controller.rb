class Users::SessionsController < Devise::SessionsController
  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_back(fallback_location: root_url)
  end

  def after_sign_in_path_for(_resource)
    # root_url
    "https://www.factory-app.com/"
  end

  def after_sign_out_path_for(_resource)
    # root_url
    "https://www.factory-app.com/"
  end
end
