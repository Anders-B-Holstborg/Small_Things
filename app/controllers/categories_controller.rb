class CategoriesController < ApplicationController
  def index
    @categories = Category.all
    @category = Category.new
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to category_path(@category)
    else
      render :new
    end
  end

  def show
    @category = find_category
  end

  def edit
    @categories = Category.all
    @category = Category.new
  end

  def update
    @category = Category.where(id: find_category.id)
    if @category.update(category_params)
      redirect_to category_path(@category)
    else
      render :new
    end
  end

  def delete
  end

  private

  def category_params
    updated_params = params.require(:category).permit(:title)
    final_params = updated_params.merge(user_id: current_user.id)
  end

  def find_category
    @category = Category.where(id: params[:id])
  end
end
