class UsersController < ApplicationController
  def index
    @users = User.where.not(latitude: nil, longitude: nil)
  end

  def dashboard
    @user = current_user
  end
end
