class ApplicationController < ActionController::Base
  helper_method :current_user

  private

  def authenticate
    redirect_to sign_in_path unless current_user
  end

  def current_user
    return @current_user if instance_variable_defined?(:@current_user)

    @current_user = User.find_by(id: cookies.signed[:user_id])
  end
end
