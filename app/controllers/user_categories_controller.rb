class UserCategoriesController < ApplicationController
  def index
    @my_categories = UserCategory.where(user_category_preference: true)
    @other_categories = UserCategory.where(user_category_preference: false)
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def show
  end
end
