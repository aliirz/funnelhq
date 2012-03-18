class UserObserver < Mongoid::Observer

  observe :user

  def after_create(user)
    unless Rails.env == "test"
      #UserMailer.welcome_email(user).deliver
    end
  end 
end
