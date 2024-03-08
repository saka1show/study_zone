class Public::CreatedproblemsController < ApplicationController

  def new
    @created_problem = CreatedProblem.new
  end

  def create
    @created_problem = CreatedProblem.new(created_problem_params)
    @created_problem.learner_id = current_learner.id
    if @created_problem.save
      redirect_to createdproblem_path(@created_problem.id)
    else
      puts @created_problem.errors.full_messages
      render :new
    end
  end

  def index
    @created_problems = CreatedProblem.where(learner_id: current_learner.id)
  end

  def index_all
    @created_problems = CreatedProblem.all
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
      redirect_to createdproblem_path(@created_problem)
    else
      render :edit
    end
  end

  def destroy
    @created_problem = CreatedProblem.find(params[:id])
    @created_problem.destroy
    redirect_to createdproblems_path
  end


  private

  def created_problem_params
    params.require(:created_problem).permit(:learner_id, :subject_id, :problem, :model_answer, :explanation, :is_release)
  end

end
