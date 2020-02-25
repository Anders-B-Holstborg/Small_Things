class ActivitiesController < ApplicationController
  def index
    @categories = Category.all.reverse
    @activities = Activity.all
  end

  def new
    @activity = Activity.new
  end

  def create
    @activity = Activity.new(activity_params)
    @activity.category = Category.find(1)
    if @activity.save!
      redirect_to activity_path(@activity)
    else
      render :new
    end
  end

  def show
    @activity = find_activity
    @user = @current_user
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

  def delete
  end

  def custom_activities
    if current_user.admin == true
      @pending_activities = Activity.where(status: 'pending')
    else
      render_404
    end
  end

  def approve
    @activity = Activity.find_by_id(params[:id])
    @activity.update(status: "approved")
    if @activity.status == "approved"
      flash[:success] = "Activity successfully approved!"
      redirect_to activities_path
    else
      flash[:error] = "Error during approval!"
      redirect_to activities_path
    end
  end

  private

  def activity_params
    updated_params = params.require(:activity).permit(:title, :description, :duration, :photo)
    final_params = updated_params.merge(user_id: current_user.id, status: 'pending')
  end

  def find_activity
    @activity = Activity.find(params[:id])
  end
end
