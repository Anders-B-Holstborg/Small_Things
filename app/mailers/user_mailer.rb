class UserMailer < ApplicationMailer
  default from: 'smallthings@smallthings.org'
  def welcome
    @user = params[:user]

    mail(to: @user.email, subject: 'Welcome to Small Things!')
  end

  def offer_activities
    @user = params[:user]
    @activity_one =  params[:activity_one]
    @activity_two = params[:activity_two]
    @booking_one = find_booking(@activity_one)
    @booking_two = find_booking(@activity_two)

    mail(to: @user.email, subject: "Today's activity!")
  end

  def find_booking(activity)
    @booking = activity.bookings.find_by(user_id: @user.id)
  end
end
