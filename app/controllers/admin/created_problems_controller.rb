class Admin::CreatedProblemsController < ApplicationController

  def index
    @subjects = Subject.all
      if params[:problem].present? && params[:subject_name].present? && params[:is_release].present? && params[:name].present?
        @created_problems = CreatedProblem.joins(:subject, :learner).where("problem LIKE ?", "%#{params[:problem]}%").where(subjects: { subject_name: params[:subject_name]}).where(is_release: params[:is_release]).where(learner: { name: params[:name]}).page(params[:page]).order(created_at: :desc)
      elsif params[:problem].present? && params[:subject_name].present? && params[:is_release].present?
        @created_problems = CreatedProblem.joins(:subject).where("problem LIKE ?", "%#{params[:problem]}%").where(subjects: { subject_name: params[:subject_name]}).where(is_release: params[:is_release]).page(params[:page]).order(created_at: :desc)
      elsif params[:problem].present? && params[:subject_name].present? && params[:name].present?
        @created_problems = CreatedProblem.joins(:subject, :learner).where("problem LIKE ?", "%#{params[:problem]}%").where(subjects: { subject_name: params[:subject_name]}).where(learner: { name: params[:name]}).page(params[:page]).order(created_at: :desc)
      elsif params[:problem].present? && params[:is_release].present? && params[:name].present?
        @created_problems = CreatedProblem.joins(:learner).where("problem LIKE ?", "%#{params[:problem]}%").where(is_release: params[:is_release]).where(learner: { name: params[:name]}).page(params[:page]).order(created_at: :desc)
      elsif params[:subject_name].present? && params[:is_release].present? && params[:name].present?
        @created_problems = CreatedProblem.joins(:subject, :learner).where(subjects: { subject_name: params[:subject_name]}).where(is_release: params[:is_release]).where(learner: { name: params[:name]}).page(params[:page]).order(created_at: :desc)
      elsif params[:problem].present? && params[:subject_name].present?
        @created_problems = CreatedProblem.joins(:subject).where("problem LIKE ?", "%#{params[:problem]}%").where(subjects: { subject_name: params[:subject_name]}).page(params[:page]).order(created_at: :desc)
      elsif params[:problem].present? && params[:is_release].present?
        @created_problems = CreatedProblem.where("problem LIKE ?", "%#{params[:problem]}%").where(is_release: params[:is_release]).page(params[:page]).order(created_at: :desc)
      elsif params[:problem].present? && params[:name].present?
        @created_problems = CreatedProblem.joins(:subject, :learner).where("problem LIKE ?", "%#{params[:problem]}%").where(learner: { name: params[:name]}).page(params[:page]).order(created_at: :desc)
      elsif params[:subject_name].present? && params[:is_release].present?
        @created_problems = CreatedProblem.joins(:subject).where(subjects: { subject_name: params[:subject_name]}).where(is_release: params[:is_release]).page(params[:page]).order(created_at: :desc)
      elsif params[:subject_name].present? && params[:name].present?
        @created_problems = CreatedProblem.joins(:subject, :learner).where(subjects: { subject_name: params[:subject_name]}).where(learner: { name: params[:name]}).page(params[:page]).order(created_at: :desc)
      elsif params[:is_release].present? && params[:name].present?
        @created_problems = CreatedProblem.joins(:learner).where(is_release: params[:is_release]).where(learner: { name: params[:name]}).page(params[:page]).order(created_at: :desc)
      elsif params[:problem].present?
        @created_problems = CreatedProblem.where("problem LIKE ?", "%#{params[:problem]}%").page(params[:page]).order(created_at: :desc)
      elsif params[:subject_name].present?
        @created_problems = CreatedProblem.joins(:subject).where(subjects: { subject_name: params[:subject_name] }).page(params[:page]).order(created_at: :desc)
      elsif params[:is_release].present?
        @created_problems = CreatedProblem.where(is_release: params[:is_release]).page(params[:page]).order(created_at: :desc)
      elsif params[:name].present?
        @created_problems = CreatedProblem.joins(:learner).where(learner: { name: params[:name]}).page(params[:page]).order(created_at: :desc)
      else
        @created_problems = CreatedProblem.page(params[:page]).order(created_at: :desc)
      end
  end

  def show
    @created_problem = CreatedProblem.find(params[:id])
    @points = 0
    @solved_problems = SolvedProblem.where(created_problem_id: @created_problem.id)
    @solved_problems.each do |solved_problem|
      if solved_problem.points.exists?
        @points += 1
      end
    end
  end

  def edit
    @created_problem = CreatedProblem.find(params[:id])
  end

  def update
    @created_problem = CreatedProblem.find(params[:id])
    if @created_problem.update(created_problem_params)
      flash[:notice] = "正しく処理されました"
      redirect_to admin_created_problem_path(@created_problem)
    else
      flash.now[:alert] = "問題の更新に失敗しました"
      render :edit
    end
  end

  def destroy
    @created_problem = CreatedProblem.find(params[:id])
    @created_problem.destroy
    redirect_to admin_created_problems_path
  end

  private

  def created_problem_params
    params.require(:created_problem).permit(:learner_id, :subject_id, :problem, :model_answer, :explanation, :is_release)
  end

end
