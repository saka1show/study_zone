class Public::FavoritesController < ApplicationController

  def create
    created_problem = CreatedProblem.find(params[:created_problem_id])
    favorite = current_learner.favorites.new(created_problem_id: created_problem.id)
    if Point.exists?(solved_problem_id: created_problem.solved_problems.first.id, learner_id: created_problem.learner_id)
      favorite.save
      solved_problem_id = created_problem.solved_problems.first.id
      redirect_to solved_problems_correct_page_path(id: solved_problem_id)
    else
      @point = created_problem.solved_problems.first.points.build
      @point.learner_id = created_problem.learner_id
      @point.solved_problem_id = created_problem.solved_problems.first.id
      @point.point = 1
      @point.owner = false
      if favorite.save && @point.save
        solved_problem_id = created_problem.solved_problems.first.id
        redirect_to solved_problems_correct_page_path(id: solved_problem_id)
      else
        render :create
      end
    end
  end

  def destroy
    created_problem = CreatedProblem.find(params[:created_problem_id])
    favorite = current_learner.favorites.find_by(created_problem_id: created_problem.id)
    favorite.destroy
    solved_problem_id = created_problem.solved_problems.first.id
    redirect_to solved_problems_correct_page_path(id: solved_problem_id)
  end

end
