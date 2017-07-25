class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    result = Authentication::Register.call user_params

    if result.success?
      redirect_to new_session_path, notice: t('.success')
    else
      @user = result.user
      flash.now.alert = t '.failure'
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :email,
      :password,
      :password_confirmation,
      :full_name,
      :birth_date,
      :small_biography
    )
  end
end
