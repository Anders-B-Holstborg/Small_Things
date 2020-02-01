class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]

  def index
  end

  def new
    if current_user
      redirect_to #Dashboard, to be implemented
    end
  end

  def create
  end

  def edit
  end

  def update
  end

  def show
  end

  def delete
  end

  def dashboard

  end
end
