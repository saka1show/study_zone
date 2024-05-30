class Public::PointsController < ApplicationController
  def index
    @points = Point.where(learner_id: current_learner.id).order(created_at: :desc)
  end

  def ranking
    today_start = Time.zone.now.beginning_of_day
    today_end = Time.zone.now.end_of_day
    @point_ranking_today = Point.where(created_at: today_start..today_end).group(:learner_id).sum(:point).sort_by { |_, v| -v }
    month_start = Time.zone.now.beginning_of_month
    month_end = Time.zone.now.end_of_month
    @point_ranking_month = Point.where(created_at: month_start..month_end).group(:learner_id).sum(:point).sort_by { |_, v| -v }
  end
end
