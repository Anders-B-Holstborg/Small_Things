class UserMailer < ApplicationMailer
  def welcome
    @user = params[:user]

    mail to: @user.email
  end

  def offer_activities
    @user = params[:user]

    mail(to: @user.email, subject: 'Welcome to Small Things!')
  end
end
