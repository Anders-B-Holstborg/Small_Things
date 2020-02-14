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

    mail(to: @user.email, subject: "Today's activity!")
  end
end
