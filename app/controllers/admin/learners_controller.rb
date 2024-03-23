class Admin::LearnersController < ApplicationController

  def index
    @learners = Learner.all
  end

  def show
    @learner = Learner.find(params[:id])
    @created_problem = CreatedProblem.where(learner_id: @learner.id).order(created_at: :desc)
    @point_today = Point.where(learner_id: @learner.id).where("strftime('%Y-%m-%d', created_at) = ?", Date.today.strftime('%Y-%m-%d')).count
    @point_this_month = Point.where(learner_id: @learner.id).where("strftime('%Y-%m', created_at) = ?", Date.today.strftime('%Y-%m')).count
    @point_all = Point.where(learner_id: @learner.id).count
  end

  def edit
    @learner = Learner.find(params[:id])
  end

  def update
    learner = Learner.find(params[:id])
    learner.update(learner_params)
    redirect_to admin_learner_path
  end

  def learner_params
    params.require(:learner).permit(:name, :name_kana, :email, :is_active)
  end

end
