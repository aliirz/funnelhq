class UserMailer < ActionMailer::Base
  
  default :from => "support@funnelhq.com"

  def welcome_email(user)
    @user = user
    @url  = "http://www.funnelhq.com"
    mail_to = Rails.env.production? ? user.email : user.email
    mail(:to => mail_to, :subject => "Welcome to Funnel HQ")
  end
  
end
