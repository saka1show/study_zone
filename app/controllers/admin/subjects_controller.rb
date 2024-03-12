class Admin::SubjectsController < ApplicationController

  def new
    @subject = Subject.new
  end

  def create
    @subject = Subject.new(subject_params)
    if @subject.save
      redirect_to admin_subjects_path
    else
      render :new
    end
  end

  def index
    @subjects = Subject.all
  end

  def edit
    @subject = Subject.find(params[:id])
    @created_problems = CreatedProblem.where(subject_id: @subject.id).order(created_at: :desc)
  end

  def update
    @subject = Subject.find(params[:id])
    if @subject.update(subject_params)
      redirect_to admin_subjects_path
    else
      render :edit
    end
  end

  private

  def subject_params
    params.require(:subject).permit(:subject_name)
  end

end
