class ActivitiesController < ApplicationController
  def index
    @activities = Activity.all
  end

  def new
    @activity = Activity.new
  end

  def create
    @activity = Activity.new(activity_params)
    if @activity.save
      redirect_to activity_path(@activity)
    else
      render :new
    end
  end

  def edit
    @activity = find_activity
  end

  def update
    @activity = Activity.new(find_activity.id)
    if @activity.update(activity_params)
      redirect_to activity_path(@activity)
    else
      render :new
    end
  end

  def show
    @activity = find_activity
  end

  def delete
  end

  private

  def activity_params
    updated_params = params.require(:category).permit(:title)
    final_params = updated_params.merge(user_id: current_user.id)
  end

  def find_activity
    @activity = Activity.where(id: params[:id])
  end
end
