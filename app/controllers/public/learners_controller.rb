class Public::LearnersController < ApplicationController

  def show
    @learner = current_learner
    @point_today = Point.where(learner_id: current_learner.id).where("strftime('%Y-%m-%d', created_at) = ?", Date.today.strftime('%Y-%m-%d')).count
    @point_this_month = Point.where(learner_id: current_learner.id).where("strftime('%Y-%m', created_at) = ?", Date.today.strftime('%Y-%m')).count
    @point_all = Point.where(learner_id: current_learner.id).count
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
