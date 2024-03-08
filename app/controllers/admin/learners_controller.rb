class Admin::LearnersController < ApplicationController

  def index
    @learners = Learner.all
  end

  def show
    @learner = Learner.find(params[:id])
    @created_problem = CreatedProblem.where(learner_id: @learner.id)
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
    params.require(:learner).permit(:name, :name_kana, :email)
  end

end
