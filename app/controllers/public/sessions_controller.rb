# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :learner_state, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  def after_sign_in_path_for(resource)
    learners_path
  end

  def after_sign_out_path_for(resource)
    new_learner_session_path
  end

  # protected

  def learner_state
    learner = Learner.find_by(email: params[:learner][:email])
    return if learner.nil?
    return unless learner.valid_password?(params[:learner][:password])
    if learner.is_active == false
      redirect_to new_learner_registration_path
    else
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
