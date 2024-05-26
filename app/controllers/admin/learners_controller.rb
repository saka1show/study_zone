class Admin::LearnersController < ApplicationController

  def index
    @learners = Learner.all
  end

  def show
    @learner = Learner.find(params[:id])
    @created_problems = CreatedProblem.where(learner_id: @learner.id).order(created_at: :desc).page(params[:page]).per(5)

    # 動作確認用
    # @point_today = Point.where(learner_id: @learner.id).where(created_at: Date.today.beginning_of_day..Date.today.end_of_day).count
    # @point_this_month = Point.where(learner_id: @learner.id).where(created_at: Date.today.beginning_of_month..Date.today.end_of_month).count

    # デプロイ用
    @point_today = Point.where(learner_id: @learner.id).where("DATE_FORMAT(created_at, '%Y-%m-%d') = ?", Date.today).count
    @point_this_month = Point.where(learner_id: @learner.id).where("DATE_FORMAT(created_at, '%Y-%m') = ?", Date.today).count

    @point_all = Point.where(learner_id: @learner.id).count
    @comments_sent = Comment.where(learner_id: @learner.id)
    @comments_received = Comment.joins(solved_problem: :created_problem).where(created_problems: { learner_id: @learner.id })
  end

  def edit
    @learner = Learner.find(params[:id])
  end

  def update
    @learner = Learner.find(params[:id])
    if @learner.update(learner_params)
      flash[:notice] = "正しく処理されました"
      redirect_to admin_learner_path
    else
      flash.now[:alert] = "登録情報の更新に失敗しました"
      render :edit
    end
  end

  def learner_params
    params.require(:learner).permit(:name, :name_kana, :email, :is_active)
  end

end
