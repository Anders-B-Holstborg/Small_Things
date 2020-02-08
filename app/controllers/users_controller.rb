class UsersController < ApplicationController
  def index
    @users = User.where.not(latitude: nil, longitude: nil)
  end

  def dashboard
    if current_user
      @user = current_user
    else
      redirect_to new_user_registration_path
    end
  end
end
