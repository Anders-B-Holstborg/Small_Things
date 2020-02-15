class BookingsController < ApplicationController
  def index
  end

  def new
    @booking = Booking.new
  end

  def create
    @user = current_user
    @user_categories = current_user.user_categories.where(user_category_preference: true).to_a
    @user_activity_one = find_activity(@user_categories)
    @user_activity_two = find_activity(@user_categories)
    UserMailer.with({user: @user, activity_one: @user_activity_one, activity_two: @user_activity_two}).deliver_now
    choose_activity_via_mail
  end

  def edit
  end

  def update
  end

  def show
  end

  def delete
  end

  private

  def find_activity(user_categories)
    rolled_user_category = user_categories.sample
    rolled_category = rolled_user_category.category
    @user_categories.delete(rolled_user_category)
    rolled_category.activities.sample
  end
end
