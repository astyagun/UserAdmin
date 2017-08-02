class DetailsDeliveriesController < ApplicationController
  include AuthorizationConcern

  before_action :require_admin!, :require_user!

  def create
    AdminMailer.user_details(@user).deliver_later
    flash.notice = t '.success'
    redirect_to admin_user_path @user
  end

  private

  def require_user!
    @user = User.select(:id).find(params[:user_id])
  end
end
