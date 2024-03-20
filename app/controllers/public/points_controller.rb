class Public::PointsController < ApplicationController

  def index
    @points = Point.where(learner_id: current_learner.id)
  end

end
