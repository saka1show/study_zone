class Public::CommentsController < ApplicationController

  def index
    @comments_sent = Comment.where(learner_id: current_learner.id)
    @comments_received = Comment.joins(solved_problem: :created_problem).where(created_problems: { learner_id: current_learner.id })
  end

  def create
    @solved_problem = SolvedProblem.find(params[:solved_problem_id])
    @comment = @solved_problem.comments.build(comment_params)
    @comment.learner_id = current_learner.id
    if @comment.save
      if @solved_problem.answer_status == true
        redirect_to solved_problems_correct_page_path(id: @solved_problem.id)
      else
        redirect_to solved_problems_incorrect_page_path(id: @solved_problem.id)
      end
      flash.delete(:notice)
    else
      flash[:alert] = "コメントの保存に失敗しました。もう一度お試しください。"
    end
  end

  def update
    @solved_problem = SolvedProblem.find(params[:id])
    @comment = Comment.find_by(solved_problem_id: @solved_problem.id)
    if @comment.update(comment_params)
      if @solved_problem.answer_status == true
        redirect_to solved_problems_correct_page_path(id: @solved_problem.id)
      else
        redirect_to solved_problems_incorrect_page_path(id: @solved_problem.id)
      end
      flash.delete(:notice)
    else
      flash[:alert] = "コメントの保存に失敗しました。もう一度お試しください。"
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to request.referrer
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :learner_id, :solved_problem_id)
  end

end
