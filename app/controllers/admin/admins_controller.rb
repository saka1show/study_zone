class Admin::AdminsController < ApplicationController

  def show
    @admin = current_admin
  end

  def edit
    @admin = current_admin
  end

  def update
    admin = current_admin
    admin.update(admin_params)
    redirect_to admin_admin_path
  end

  def unsubscribe
    @admin = current_admin
  end

  def withdraw
    admin = current_admin
    admin.update(is_active: false)
    reset_session
    redirect_to root_path
  end

  private

  def admin_params
    params.require(:admin).permit(:name, :email)
  end

end
