class Public::SolvedProblemsController < ApplicationController

  def new
    created_problem_id = params[:created_problem_id]
    @created_problem = CreatedProblem.find(created_problem_id)
    if learner_signed_in?
      if SolvedProblem.exists?(created_problem_id: @created_problem.id, learner_id: current_learner.id, answer_status: false)
        @solved_problem = SolvedProblem.find_by(created_problem_id: @created_problem.id, learner_id: current_learner.id)
      else
        @solved_problem = SolvedProblem.new
      end
    else
      @solved_problem = SolvedProblem.new
    end
  end

  def answer
    if learner_signed_in?
      created_problem_id = params[:created_problem_id]
      @created_problem = CreatedProblem.find(created_problem_id)
      @solved_problem = SolvedProblem.new(solved_problem_params)
      @solved_problem.created_problem_id = @created_problem.id
      @solved_problem.learner_id = current_learner.id
      @solved_problem.answer_status = false
    else
      created_problem_id = params[:created_problem_id]
      @created_problem = CreatedProblem.find(created_problem_id)
      @solved_problem = SolvedProblem.new(solved_problem_params)
      @solved_problem.created_problem_id = @created_problem.id
      @solved_problem.learner_id = 1
      @solved_problem.answer_status = false
    end
  end

  def correct
    @solved_problem = SolvedProblem.new(solved_problem_params)
    if @solved_problem.save
      redirect_to solved_problems_correct_page_path(id: @solved_problem.id)
    else
      render :correct
    end
  end

  def incorrect
    @solved_problem = SolvedProblem.new(solved_problem_params)
    if @solved_problem.save
      redirect_to solved_problems_incorrect_page_path(id: @solved_problem.id)
    else
      render :incorrect
    end
  end

  def correct_page
    if learner_signed_in?
      @solved_problem = SolvedProblem.find(params[:id])
    else
      created_problem_id = params[:created_problem_id]
      @created_problem = CreatedProblem.find(created_problem_id)
    end
  end

  def incorrect_page
    if learner_signed_in?
      @solved_problem = SolvedProblem.find(params[:id])
    else
      created_problem_id = params[:created_problem_id]
      @created_problem = CreatedProblem.find(created_problem_id)
    end
  end

  def index
    @solved_problems = SolvedProblem.where(learner_id: current_learner.id).order(created_at: :desc)
  end

  def destroy
    @solved_problem = SolvedProblem.find(params[:id])
    @solved_problem.destroy
    redirect_to created_problems_all_path
  end

  private

  def solved_problem_params
    params.require(:solved_problem).permit(:answer, :answer_status, :learner_id, :created_problem_id)
  end
end