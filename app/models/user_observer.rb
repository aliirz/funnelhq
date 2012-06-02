class UserObserver < Mongoid::Observer

  observe :user

  def after_create(user)
    if Rails.env.production?
      UserMailer.welcome_email(user).deliver
    end
  end 
end
