class Public::LearnersController < ApplicationController

  def show
    @learner = current_learner

    # 動作確認用
    # @point_today = Point.where(learner_id: current_learner.id).where(created_at: Date.today.beginning_of_day..Date.today.end_of_day).count
    # @point_this_month = Point.where(learner_id: current_learner.id).where(created_at: Date.today.beginning_of_month..Date.today.end_of_month).count

    # デプロイ用
    @point_today = Point.where(learner_id: current_learner.id).where("DATE_FORMAT(created_at, '%Y-%m-%d') = ?", Date.today).count
    @point_this_month = Point.where(learner_id: current_learner.id).where("DATE_FORMAT(created_at, '%Y-%m') = ?", Date.today).count

    @point_all = Point.where(learner_id: current_learner.id).count
  end

  def edit
    @learner = current_learner
  end

  def update
    learner = current_learner
    if learner.update(learner_params)
      flash[:notice] = "正しく処理されました"
      redirect_to learner_path
    else
      flash.now[:alert] = "登録情報の更新に失敗しました"
      render :edit
    end
  end

  def unsubscribe
    @learner = current_learner
  end

  def withdraw
    learner = current_learner
    learner.update(is_active: false)
    reset_session
    flash[:notice] = "ご利用ありがとうございました"
    redirect_to root_path
  end

  private

  def learner_params
    params.require(:learner).permit(:name, :name_kana, :email, :encrypted_password)
  end

end
