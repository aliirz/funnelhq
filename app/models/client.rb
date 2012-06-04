class Client
  
  include Core::Mongoid::Document
  
  EMAIL_REGEX = /^[A-Z0-9._%-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i
  
  ## fields ##
  
  field :first_name, :type => String
  field :last_name, :type => String
  field :email, :type => String
  field :telephone, :type => String
  field :address1, :type => String
  field :address2, :type => String
  field :address3, :type => String
  
  ## Validation ##
  
  validates_presence_of :first_name, :last_name
  validates :email, presence: true, uniqueness: true, format: { with: EMAIL_REGEX }
  
  ## ##
  
  embedded_in :user, :inverse_of => :clients

  ## Methods ##
  
  # Returns a users full name
  #
  # @param 
  # @return
  
  def full_name
    "#{self.first_name} #{self.last_name}"
  end
  
  # Return a users full address as a string
  # @return [String]
  #
  
  def full_address
    "#{self.address1}, #{self.address2}, #{self.address3}"
  end
  
  # I find name quicker to remember
  
  alias_method :name, :full_name
  
  
  #
  # Every client will have a private dashboard giving information about
  # their projects and updates from the user.
  #
  def dashboard_url(user,client)
    "/clients/#{user.id}/#{client.id}/dashboard"
  end
end