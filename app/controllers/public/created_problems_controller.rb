class Public::CreatedProblemsController < ApplicationController

  def new
    @created_problem = CreatedProblem.new
  end

  def create
    @created_problem = CreatedProblem.new(created_problem_params)
    @created_problem.learner_id = current_learner.id
    if @created_problem.save
      redirect_to created_problem_path(@created_problem.id)
    else
      flash.now[:alert] = "問題の作成に失敗しました"
      render :new
    end
  end

  def index
    @subjects = Subject.all
    if learner_signed_in?
      if params[:problem].present? && params[:subject_name].present? && params[:is_release].present?
        @created_problems = CreatedProblem.joins(:subject).where("problem LIKE ?", "%#{params[:problem]}%").where(subjects: { subject_name: params[:subject_name]}).where(is_release: params[:is_release]).where(learner_id: current_learner.id).where(delete_status: false).order(created_at: :desc)
      elsif params[:problem].present? && params[:subject_name].present?
        @created_problems = CreatedProblem.joins(:subject).where("problem LIKE ?", "%#{params[:problem]}%").where(subjects: { subject_name: params[:subject_name]}).where(learner_id: current_learner.id).where(delete_status: false).order(created_at: :desc)
      elsif params[:problem].present? && params[:is_release].present?
        @created_problems = CreatedProblem.where("problem LIKE ?", "%#{params[:problem]}%").where(is_release: params[:is_release]).where(learner_id: current_learner.id).where(delete_status: false).order(created_at: :desc)
      elsif params[:subject_name].present? && params[:is_release].present?
        @created_problems = CreatedProblem.joins(:subject).where(subjects: { subject_name: params[:subject_name]}).where(is_release: params[:is_release]).where(learner_id: current_learner.id).where(delete_status: false).order(created_at: :desc)
      elsif params[:problem].present?
        @created_problems = CreatedProblem.where("problem LIKE ?", "%#{params[:problem]}%").where(learner_id: current_learner.id).where(delete_status: false).order(created_at: :desc)
      elsif params[:subject_name].present?
        @created_problems = CreatedProblem.joins(:subject).where(subjects: { subject_name: params[:subject_name] }).where(learner_id: current_learner.id).where(delete_status: false).order(created_at: :desc)
      elsif params[:is_release].present?
        @created_problems = CreatedProblem.where(is_release: params[:is_release]).where(learner_id: current_learner.id).where(delete_status: false).order(created_at: :desc)
      else
        @created_problems = CreatedProblem.where(learner_id: current_learner.id).where(delete_status: false).order(created_at: :desc)
      end
    else
    end
  end

  def index_all
    @subjects = Subject.all
      if params[:problem].present? && params[:subject_name].present? && params[:name].present?
        @created_problems = CreatedProblem.joins(:subject, :learner).where("problem LIKE ?", "%#{params[:problem]}%").where(subjects: { subject_name: params[:subject_name]}).where(learner: { name: params[:name]}).where(delete_status: false).where(is_release: true).page(params[:page]).per(10).order(created_at: :desc)
      elsif params[:problem].present? && params[:subject_name].present?
        @created_problems = CreatedProblem.joins(:subject).where("problem LIKE ?", "%#{params[:problem]}%").where(subjects: { subject_name: params[:subject_name]}).where(delete_status: false).where(is_release: true).page(params[:page]).per(10).order(created_at: :desc)
      elsif params[:problem].present? && params[:name].present?
        @created_problems = CreatedProblem.joins(:learner).where("problem LIKE ?", "%#{params[:problem]}%").where(learner: { name: params[:name]}).where(delete_status: false).where(is_release: true).page(params[:page]).per(10).order(created_at: :desc)
      elsif params[:subject_name].present? && params[:name].present?
        @created_problems = CreatedProblem.joins(:subject, :learner).where(subjects: { subject_name: params[:subject_name]}).where(learner: { name: params[:name]}).where(delete_status: false).where(is_release: true).page(params[:page]).per(10).order(created_at: :desc)
      elsif params[:problem].present?
        @created_problems = CreatedProblem.where("problem LIKE ?", "%#{params[:problem]}%").where(delete_status: false).where(is_release: true).page(params[:page]).per(10).order(created_at: :desc)
      elsif params[:subject_name].present?
        @created_problems = CreatedProblem.joins(:subject).where(subjects: { subject_name: params[:subject_name] }).where(delete_status: false).where(is_release: true).page(params[:page]).per(10).order(created_at: :desc)
      elsif params[:name].present?
        @created_problems = CreatedProblem.joins(:learner).where(learner: { name: params[:name]}).where(delete_status: false).where(is_release: true).page(params[:page]).per(10).order(created_at: :desc)
      else
        @created_problems = CreatedProblem.where(delete_status: false).where(is_release: true).page(params[:page]).per(10).order(created_at: :desc)
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
    if SolvedProblem.exists?(created_problem_id: @created_problem.id, learner_id: current_learner.id)
      @solved_problem = SolvedProblem.find_by(created_problem_id: @created_problem.id, learner_id: current_learner.id)
    end
  end

  def edit
    @created_problem = CreatedProblem.find(params[:id])
  end

  def update
    @created_problem = CreatedProblem.find(params[:id])
    if @created_problem.update(created_problem_params)
      flash[:notice] = "正しく処理されました"
      redirect_to created_problems_path
    else
      flash.now[:alert] = "問題の更新に失敗しました"
      render :edit
    end
  end

  private

  def created_problem_params
    params.require(:created_problem).permit(:learner_id, :subject_id, :problem, :model_answer, :explanation, :is_release, :delete_status)
  end

end
