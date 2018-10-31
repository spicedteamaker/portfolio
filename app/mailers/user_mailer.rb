class UserMailer < ApplicationMailer

  def welcome_email
    user = params[:user]
    @url = "http://localhost:3000"
    mail(to: user.email, subject: "Test!")
  end
end
