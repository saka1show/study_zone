class Admin::CreatedproblemsController < ApplicationController

  def index
    @created_problems = CreatedProblem.all.order(created_at: :desc)
  end

  def show
    @created_problem = CreatedProblem.find(params[:id])
  end

  def edit
    @created_problem = CreatedProblem.find(params[:id])
  end

  def update
    @created_problem = CreatedProblem.find(params[:id])
    if @created_problem.update(created_problem_params)
      redirect_to admin_createdproblem_path(@created_problem)
    else
      render :edit
    end
  end

  def destroy
    @created_problem = CreatedProblem.find(params[:id])
    @created_problem.destroy
    redirect_to admin_createdproblems_path
  end

  private

  def created_problem_params
    params.require(:created_problem).permit(:learner_id, :subject_id, :problem, :model_answer, :explanation, :is_release)
  end

end
