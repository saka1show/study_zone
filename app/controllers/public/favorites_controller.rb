class Public::FavoritesController < ApplicationController

  def create
    created_problem = CreatedProblem.find(params[:created_problem_id])
    solved_problem = created_problem.solved_problems.first
    favorite = current_learner.favorites.new(created_problem_id: created_problem.id)
    if Point.exists?(solved_problem_id: solved_problem.id, learner_id: created_problem.learner_id)
      favorite.save
      redirect_to solved_problems_correct_page_path(id: solved_problem.id)
    else
      point = solved_problem.points.build(
        learner_id: created_problem.learner_id,
        point: 1,
        owner: false
      )

      if favorite.save && point.save
        redirect_to solved_problems_correct_page_path(id: solved_problem.id)
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
