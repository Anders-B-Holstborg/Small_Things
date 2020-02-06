class UserCategoriesController < ApplicationController
  def index
    @my_categories = UserCategory.where(user_category_preference: true)
    @other_categories = UserCategory.where(user_category_preference: false)
  end

  def new
    @category = Category.find(params[:category_id])
    @my_category = UserCategory.new
  end

  def create
    @my_category = UserCategory.new(user_category_params)
    if @my_category.save
      redirect_to category_user_category_path(@my_category.category, @my_category)
    else
      render :new
    end
  end

  def edit
    @category = Category.find(params[:category_id])
    @my_category = find_my_category
  end

  def show
    @my_category = find_my_category
  end

  def update
  end

  private

  def user_category_params
    params.require(:user_category).permit(:user_category_preference, :time_length_preference).merge(user_id: current_user.id, category_id: params[:category_id])
  end

  def find_my_category
    @my_category = UserCategory.find_by(user: current_user, category: params[:category_id])
  end
end
