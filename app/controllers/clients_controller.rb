class ClientsController < ApplicationController
  
  respond_to :html
  
  before_filter :find_client, :only => [:show, :edit, :update, :destroy]
  
  def index
    @clients = @user.clients.page(params[:page]) 
    respond_with @clients
  end

  def show
    respond_with @client
  end

  def new
    @client = @user.clients.new
    respond_with @client
  end

  def edit
  end

  def create
    @client = @user.clients.new(params[:client])

    respond_to do |format|
      if @client.save
        format.html { redirect_to @client, notice: 'Client was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    respond_to do |format|
      if @client.update_attributes(params[:client])
        format.html { redirect_to @client, notice: 'Client was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @client.destroy

    respond_to do |format|
      format.html { redirect_to clients_url }
    end
  end
  
  # 
  # This is the client dashboard where users can share project 
  # information with clients. It will list all projects associated
  # with the client and show messages from the user to the client.
  # It should also give a general overview of a project progress. (i.e working on design etc)
  #
  # Requires a separate layout and also it should be available without authentication.
  #
  # url => /clients/:user_id/:id/dashboard
  #
  def dashboard
    @owner = User.find(params[:user_id])
    @client = @owner.clients.find(params[:id])
    render :layout => 'share'
  end
  
  private 
  
  def find_client
    @client = @user.clients.find(params[:id])
  end
end