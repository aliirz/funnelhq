class AccountsController < ApplicationController
  
  # We will restrict access to the main accounts page for 
  
  before_filter :verify_primary_account_holder, :only => [:index]
  
  before_filter :find_account, :only => [:show, :edit, :update]
  
  skip_before_filter :authenticate_user!, :only => [:new, :create]
  
  def index
    @accounts = Account.all
  end
  
  def new
    @account = Account.new
    @account.users.build
    @plan = params[:plan_name]
    
    respond_to do |format|
       format.html {render :layout => 'pages'}
    end
  end
  
  def create
    
    @account = Account.new
    @account.users.build(params[:account][:users])
    
    #@account.account_plan_id = @account_plan.id
  
    respond_to do |format|
      if @account.save
        format.html {
          redirect_to "/"
          #@account.recurly_account_code = @account.id
          #@account.save
          #redirect_to @account.account_plan.recurly_signup_link(@account.users.first)
        }
      else
        format.html { render :new, :layout => 'pages' }
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
        format.html { render action: "edit" }
      end
    end
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
