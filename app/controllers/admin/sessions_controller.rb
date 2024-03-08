# frozen_string_literal: true

class Admin::SessionsController < Devise::SessionsController
  before_action :admin_state, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # # POST /resource/sign_in
  # def create
  #   super
  # end

  # # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  def after_sign_in_path_for(resource)
    admin_path
  end

  def after_sign_out_path_for(resource)
    new_admin_session_path
  end

  # protected

  def admin_state
    admin = Admin.find_by(email: params[:admin][:email])
    return if admin.nil?
    return unless admin.valid_password?(params[:admin][:password])
    if admin.is_active == false
      redirect_to new_admin_registration_path
    else
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
