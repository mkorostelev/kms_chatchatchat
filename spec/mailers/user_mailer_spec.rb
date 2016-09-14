require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  include EmailSpec::Matchers
  include EmailSpec::Helpers

  describe "#welcome_email" do
    # def welcome_email(user)
    #   @user = user.decorate
    #   @url  = 'http://example.com/login'
    #   mail(to: @user.email, subject: "Welcome #{@user.full_name} enjoy your stay")
    # end
    let(:user) { stub_model User, email: 'test@mail.com', first_name: 'Name', last_name: 'Surname' }
    let(:email) { UserMailer.welcome_email(user) }
    it "sets to be delivered to provided email" do
      expect(email).to deliver_to('test@mail.com')
    end

    it "has welcome message in the body" do
      expect(email).to have_body_text("Welcome to example.com")
    end

    it "has subject" do
      expect(email).to have_subject('Welcome Name Surname enjoy your stay')
    end
  end

  describe "#new_message_email" do
    # def new_message_email(user, chat)
    #   @user = user.decorate
    #   @chat = chat.decorate(context: { user: user })
    #   mail(to: @user.email, subject: "You have new message in #{@chat.name} conversation.")
    # end
    let(:user) { stub_model User, email: 'test@mail.com', first_name: 'Name', last_name: 'Surname' }

    let(:chat) { stub_model Chat, name: 'Name' }

    let(:email) { UserMailer.new_message_email(user, chat) }

    it "sets to be delivered to provided email" do
      expect(email).to deliver_to('test@mail.com')
    end

    it "has welcome message in the body" do
      expect(email).to have_body_text('Name Surname! You have new mesasge in, Name')
    end

    it "has subject" do
      expect(email).to have_subject('You have new message in Name conversation.')
    end
  end

  describe "#new_chat_invited_email" do
    # def new_chat_invited_email(user, chat)
    #   @user = user.decorate
    #   @chat = chat.decorate(context: { user: user })
    #   mail(to: @user.email, subject: "You was invited to #{@chat.name} conversation.")
    # end
    let(:user) { stub_model User, email: 'test@mail.com', first_name: 'Name', last_name: 'Surname' }

    let(:chat) { stub_model Chat, name: 'Name' }

    let(:email) { UserMailer.new_chat_invited_email(user, chat) }

    it "sets to be delivered to provided email" do
      expect(email).to deliver_to('test@mail.com')
    end

    it "has welcome message in the body" do
      expect(email).to have_body_text('Name Surname! You was invited to Name conversation.')
    end

    it "has subject" do
      expect(email).to have_subject('You was invited to Name conversation.')
    end
  end
end
