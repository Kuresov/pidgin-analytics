class UserMailer < ApplicationMailer

  def registration_confirmation(user)
    @user = user
    mail(
      to: @user.email,
      subject: "Welcome to Pidgin Analytics!"
    )
  end
end
