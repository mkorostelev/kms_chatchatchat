class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def welcome_email(user)
    @user = user.decorate
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: "Welcome #{@user.full_name} enjoy your stay")
  end

  def new_message_email(user, chat)
    @user = user.decorate
    @chat = chat.decorate(context: { user: user })
    mail(to: @user.email, subject: "You have new message in #{@chat.name} conversation.")
  end

  def new_chat_invited_email(user, chat)
    @user = user.decorate
    @chat = chat.decorate(context: { user: user })
    mail(to: @user.email, subject: "You was invited to #{@chat.name} conversation.")
  end
end
