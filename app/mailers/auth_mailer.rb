class AuthMailer < ApplicationMailer
  def success(user)
    @user = user
    mail to: @user.email, subject: 'Success Mail Test'
  end

  def fails
  end
end
