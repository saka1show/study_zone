class Public::CommentsController < ApplicationController

  def index
  end

  def create
    @solved_problem = SolvedProblem.find(params[:solved_problem_id])
    @comment = @solved_problem.comments.build(comment_params)
    @comment.learner_id = current_learner.id
    if @comment.save
      redirect_to solved_problems_correct_page_path(id: @solved_problem.id)
    else
      render :create
    end
  end

  def update
    @solved_problem = SolvedProblem.find(params[:solved_problem_id])
    @comment = Comment.find_by(solved_problem_id: @solved_problem.id)
    if @comment.update(comment_params)
      redirect_to solved_problems_correct_page_path(id: @solved_problem.id)
    else
      render :update
    end
  end

  def destroy
    @solved_problem = SolvedProblem.find(params[:solved_problem_id])
    @comment = Comment.find_by(learner_id: current_learner.id, solved_problem_id: @solved_problem.id)
    @comment.destroy
    redirect_to solved_problems_correct_page_path(id: @solved_problem.id)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

end
