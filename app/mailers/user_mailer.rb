class UserMailer < ApplicationMailer
  default from: "notifications@example.com"

  def welcome_email
    #@user = current_user
    @url = "http://localhost:3000"
    mail(to: "smtp://127.0.0.1:1025", subject: "Test!")
  end
end
