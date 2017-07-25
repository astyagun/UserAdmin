class SessionsController < ApplicationController
  def new; end

  def create
    result = Authentication::Check.call session_params

    if result.success?
      session[:user_id] = result.user.id
      redirect_to create_success_redirect_path(result), notice: t('.success')
    else
      flash.now.alert = result.message
      render :new
    end
  end

  def destroy
    session.delete :user_id
    redirect_to new_session_path, notice: t('.success')
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end

  def create_success_redirect_path(result)
    result.user.admin? ? admin_users_path : home_path
  end
end
