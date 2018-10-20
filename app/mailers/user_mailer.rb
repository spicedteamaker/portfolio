class UserMailer < ApplicationMailer

  def welcome_email
    @user = current_user
    @url = "http://localhost:3000"
    mail(to: @user.email, subject: "Test!")
  end
end
