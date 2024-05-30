class ApplicationController < ActionController::Base
  before_action :set_point_ranking_today, :set_point_ranking_month

  private
    def set_point_ranking_today
      today_start = Time.zone.now.beginning_of_day
      today_end = Time.zone.now.end_of_day
      @point_ranking_today = Point.where(created_at: today_start..today_end).group(:learner_id).sum(:point).sort_by { |_, v| -v }
    end

    def set_point_ranking_month
      month_start = Time.zone.now.beginning_of_month
      month_end = Time.zone.now.end_of_month
      @point_ranking_month = Point.where(created_at: month_start..month_end).group(:learner_id).sum(:point).sort_by { |_, v| -v }
    end
end
