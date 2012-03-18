class ApplicationController < ActionController::Base
  
  protect_from_forgery
  
  # Only skip this for static pages
  
  before_filter :authenticate_user!
  before_filter :find_user
  before_filter :check_signup_complete!
  around_filter :set_time_zone
  
  layout :layout_by_resource
  
  private 
  
  # Used in all controllers to find the current user

  def find_user
    @user = current_user
  end
  
  # Set the time zone for a user account
  
  def set_time_zone
    old_time_zone = Time.zone
    Time.zone = current_user.account.time_zone if user_signed_in? && !Rails.env == 'test'
    yield
  ensure
    Time.zone = old_time_zone
  end
  
  # Checks if an account holder has completed the signup process
  #
  def check_signup_complete!
    if user_signed_in? && !current_user.account.free_plan?
      unless @user.account.signup_complete == true
        sign_out :user 
        redirect_to "/"
      end
    end
  end

  # Render the correct layout for a given action

  def layout_by_resource
    if devise_controller? and controller_name == 'passwords'
      'login'
    elsif devise_controller? and action_name != 'edit'
      'login'
    else
      'application'
    end
  end
end
