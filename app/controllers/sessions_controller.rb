class SessionsController < ApplicationController
  layout "core"

  before_action :authenticate, only: %i[destroy]

  def new
  end

  def create
    user = User.find_by(username: params[:username])

    if user&.authenticate(params[:password])
      reset_session
      cookies.signed.permanent[:user_id] = {value: user.id, httponly: true}

      redirect_to root_path, notice: "Signed in successfully"
    else
      redirect_to sign_in_path(username_hint: params[:username]), alert: "That username or password is incorrect"
    end
  end

  def destroy
    cookies.delete(:user_id)
    reset_session

    redirect_to root_path, notice: "Signed out successfully"
  end
end
