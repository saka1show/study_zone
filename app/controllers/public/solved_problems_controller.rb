class Public::SolvedProblemsController < ApplicationController

  def new
    created_problem_id = params[:created_problem_id]
    @created_problem = CreatedProblem.find(created_problem_id)
    if learner_signed_in?
      if SolvedProblem.exists?(created_problem_id: @created_problem.id, learner_id: current_learner.id, answer_status: false)
        @solved_problem = SolvedProblem.find_by(created_problem_id: @created_problem.id, learner_id: current_learner.id)
        @solved_problem.points.build
      else
        @solved_problem = SolvedProblem.new
        @solved_problem.points.build
      end
    else
      @solved_problem = SolvedProblem.new
      @solved_problem.points.build
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
      @point = @solved_problem.points.build
      @point.learner_id = current_learner.id
      @point.solved_problem_id = @solved_problem.id
      @point.point = 1
      @point.owner = true
    else
      created_problem_id = params[:created_problem_id]
      @created_problem = CreatedProblem.find(created_problem_id)
      @solved_problem = SolvedProblem.new(solved_problem_params)
      @solved_problem.created_problem_id = @created_problem.id
      @solved_problem.learner_id = 1
      @solved_problem.answer_status = false
      @point = @solved_problem.points.build
      @point.learner_id = 0
      @point.solved_problem_id = @solved_problem.id
      @point.point = 1
      @point.owner = true
    end
  end

  def correct
    @solved_problem = SolvedProblem.new(solved_problem_params)
    if SolvedProblem.exists?(created_problem_id: @solved_problem.created_problem_id, learner_id: current_learner.id, answer_deleted: false)
      if @solved_problem.save
        redirect_to solved_problems_correct_page_path(id: @solved_problem.id)
      else
        render :correct
      end
    else
      if SolvedProblem.exists?(created_problem_id: @solved_problem.created_problem_id, learner_id: current_learner.id)
        if @solved_problem.save
          redirect_to solved_problems_correct_page_path(id: @solved_problem.id)
        else
          render :correct
        end
      elsif learner_signed_in?
        @point = @solved_problem.points.build
        @point.learner_id = current_learner.id
        @point.solved_problem_id = @solved_problem.id
        @point.point = 1
        @point.owner = true
        if @solved_problem.save && @point.save
          redirect_to solved_problems_correct_page_path(id: @solved_problem.id)
        else
          render :correct
        end
      else
      end
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
      @created_problem = CreatedProblem.find(@solved_problem.created_problem_id)
      @comment = Comment.find_by(solved_problem_id: @solved_problem.id)
    else
      created_problem_id = params[:created_problem_id]
      @created_problem = CreatedProblem.find(created_problem_id)
    end
  end

  def incorrect_page
    if learner_signed_in?
      @solved_problem = SolvedProblem.find(params[:id])
      @created_problem = CreatedProblem.find(@solved_problem.created_problem_id)
      @comment = Comment.find_by(solved_problem_id: @solved_problem.id)
    else
      created_problem_id = params[:created_problem_id]
      @created_problem = CreatedProblem.find(created_problem_id)
    end
  end

  def index
    if params[:learner_id].present?
      @solved_problems = SolvedProblem.joins(created_problem: :favorites).where(favorites: { learner_id: params[:learner_id]}).where(answer_deleted: false).order(created_at: :desc)
    else
      @solved_problems = SolvedProblem.where(learner_id: current_learner.id).order(created_at: :desc)
    end
  end

  def update
    created_problem = CreatedProblem.find(params[:id])
    solved_problems = SolvedProblem.where(created_problem_id: created_problem.id, learner_id: current_learner.id)
    solved_problems.update(solved_problem_params)
    redirect_to created_problems_all_path
  end

  private

  def solved_problem_params
    params.require(:solved_problem).permit(:answer, :answer_status, :learner_id, :created_problem_id, :answer_deleted, points_attributes: [:learner_id, :solved_problem_id, :point, :owner])
  end

end