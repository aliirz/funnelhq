class AccountsController < ApplicationController
  
  # We will restrict access to the main accounts page for 
  
  before_filter :verify_primary_account_holder, :only => [:index]
  before_filter :find_account, :only => [:show, :edit, :update]
  skip_before_filter :authenticate_user!, :only => [:new, :create, :complete_signup]
  
  def index
    @accounts = Account.all
  end
  
  def new
    @account = Account.new
    @account.users.build
    @plan = params[:account_plan]
    
    respond_to do |format|
       format.html {render :layout => 'pages'}
    end
  end
  
  def create 
    @account = Account.new(params[:account])
    @account.account_plan = params[:account_plan]
    respond_to do |format|
      if @account.save
        format.html {
          if @account.free_plan?
            redirect_to "/users/login"
          else
            redirect_to @account.recurly_signup_link
          end
        }
      else
        format.html {
          @plan = params[:account_plan]
          render :new, :layout => 'pages'
        }
      end
    end
  end

  def show  
  end

  def edit
  end
  
  def update
    respond_to do |format|
      if @account.update_attributes(params[:account])
        format.html { redirect_to @account, notice: 'Account was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end
  
  #
  # Recurly callback URL
  def complete_signup 
    @account = Account.find(params[:id])
    @account.signup_complete = true
    @account.save
    redirect_to "http://www.funnelhq.com"
  end
  
  private
  
  def find_account
    @account = Account.find(params[:id])
  end
  
  # There is only one primary account holder for an application
  
  def verify_primary_account_holder
    redirect_to dashboard_path and return
  end
end
