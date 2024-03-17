class Public::PointsController < ApplicationController

  def index
    @points = Point.where(learner_id: current_learner.id)
    @point_all = 0
    @points.each do |point|
      @point_all + 1
    end
  end

end
