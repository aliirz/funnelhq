class SubscriptionsController < ApplicationController
  
  before_filter :find_subscription
  
  def index
  end

  def create
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end
  
  private
  
  def find_subscription
    @subscription = Recurly::Account.find(current_user.account.id)
  end
end
