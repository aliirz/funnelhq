class Account
  
  include Core::Mongoid::Document
  
  CURRENCY_SYMBOLS = { :usd => '&dollar;', :gbp => '&pound;', :eur => '&euro;'}
  
  FREE =       { :project_limit => 2, :upload_limit => 10000, :invoice_limit => 2 }
  STANDARD =   { :project_limit => 20, :upload_limit => 50000, :invoice_limit => 10 }
  PRO =        { :project_limit => 100, :upload_limit => 100000, :invoice_limit => 50 }
  
  references_many :users, :inverse_of => :account, :autosave => true, dependent: :delete
  
  accepts_nested_attributes_for :users
  
  ## fields ##

  field :time_zone, :default => 'Eastern Time (US & Canada)'
  field :currency, :type => String, :default => 'gbp'
  field :invoice_message, :default => 'Thank you for your custom. If you have any questions about this invoice please get in touch.'
  field :account_plan, :type => String, :default => 'free'
  
  # Subscription
  
  field :signup_complete, :type => Boolean, :default => false

  # Business Information
  
  field :company_registration_number, :type => String
  field :end_of_year, :type => String
  field :hourly_rate, :type => Integer
  
  # Returns a string representation of account currency
  # Example: Account.last.get_currency => '&pound;'
  #
  # @param 
  # @return
  
  def get_currency
    CURRENCY_SYMBOLS[self.currency.to_sym]
  end
  
  # Used as a helper for select boxes when dealing with currency
  #
  # @param 
  # @return [Array] an array of supported currencies
  
  def currency_array
    CURRENCY_SYMBOLS.keys.map{ |c| c.to_s }
  end
  
  # Access account information thorugh this method
  #
  # @param 
  # @return []
  
  def get_setting(plan, setting)
    Account.const_get(plan.upcase)["#{setting}_limit".to_sym]
  end 
   
  #
  #
  def recurly_signup_link
    user = self.users.first
    params = "?email=#{user.email}&first_name=#{user.first_name}&last_name=#{user.last_name}"
    "https://funnel.recurly.com/subscribe/#{self.account_plan}/#{self.id}" << params
  end
  
  # Returns true if this is a free account plan
  #
  def free_plan?
    self.account_plan == 'free'
  end
  
  # Return true if the user has completed the Recurly signup
  #
  def signup_complete?
    self.signup_complete
  end   
end
