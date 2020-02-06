class UserCategoriesController < ApplicationController
  def index
    @user_categories = UserCategory.where(user_category_preference: true)
    @other_categories = UserCategory.where(user_category_preference: false)
  end

  def new
    @category = Category.find(params[:category_id])
    @user_category = UserCategory.new
  end

  def create
    @user_category = UserCategory.new(user_category_params)
    if @user_category.save
      redirect_to category_user_category_path(@user_category.category, @user_category)
    else
      render :new
    end
  end

  def edit
    @category = Category.find(params[:category_id])
    @user_category = find_user_category
  end

  def show
    @user_category = find_user_category
  end

  def update
  end

  private

  def user_category_params
    params.require(:user_category).permit(:user_category_preference, :time_length_preference).merge(user_id: current_user.id, category_id: params[:category_id])
  end

  def find_user_category
    @user_category = UserCategory.find_by(user: current_user, category: params[:category_id])
  end
end
