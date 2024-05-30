class Admin::AdminsController < ApplicationController

  def show
    @admin = current_admin
  end

  def edit
    @admin = current_admin
  end

  def update
    @admin = current_admin
    if @admin.update(admin_params)
      flash[:notice] = "正しく処理されました"
      redirect_to admin_admin_path
    else
      flash.now[:alert] = "登録情報の更新に失敗しました"
      render :edit
    end
  end

  def unsubscribe
    @admin = current_admin
  end

  def withdraw
    admin = current_admin
    admin.update(is_active: false)
    reset_session
    flash[:notice] = "ご利用ありがとうございました"
    redirect_to root_path
  end

  private

  def admin_params
    params.require(:admin).permit(:name, :email)
  end

end
