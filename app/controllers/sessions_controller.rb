class SessionsController < ApplicationController
  def new
    redirect_to logged_in_redirect_path(current_user) if user_logged_in?
  end

  def create
    result = Authentication::Check.call session_params

    if result.success?
      session[:user_id] = result.user.id
      redirect_to logged_in_redirect_path(result.user), notice: t('.success')
    else
      flash.now.alert = result.message
      render :new
    end
  end

  def destroy
    log_out
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end

  def logged_in_redirect_path(user)
    user.admin? ? admin_users_path : home_path
  end
end
