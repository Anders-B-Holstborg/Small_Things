# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/welcome
  def welcome
    UserMailer.welcome
  end

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/offer_activities
  def offer_activities
    UserMailer.offer_activities
  end

end
