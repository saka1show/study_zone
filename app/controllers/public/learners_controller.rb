class Public::LearnersController < ApplicationController

  def show
    @learner = current_learner
  end

  def edit
    @learner = current_learner
  end

  def update
    learner = current_learner
    learner.update(learner_params)
    redirect_to learner_path
  end

  def unsubscribe
    @learner = current_learner
  end

  def withdraw
    learner = current_learner
    learner.update(is_active: false)
    reset_session
    redirect_to root_path
  end

  private

  def learner_params
    params.require(:learner).permit(:name, :name_kana, :email, :encrypted_password)
  end

end
