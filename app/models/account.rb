class Account
  
  include Core::Mongoid::Document
  
  CURRENCY_SYMBOLS = { :usd => '&dollar;', :gbp => '&pound;', :eur => '&euro;'}
  
  FREE = { :project_limit => 2, :upload_limit => 10000, :invoice_limit => 2 }
  STANDARD = { :project_limit => 20, :upload_limit => 50000, :invoice_limit => 10 }
  PRO = { :project_limit => 100, :upload_limit => 100000, :invoice_limit => 50 }
  
  references_many :users, :inverse_of => :account, :autosave => true
  
  accepts_nested_attributes_for :users
  
  ## fields ##

  field :time_zone, :default => 'Eastern Time (US & Canada)'
  field :currency, :type => String, :default => 'gbp'
  field :invoice_message, :default => 'Thank you for your custom. We look forward to working with you again.'
  field :account_plan, :type => String, :default => 'free'
  
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
end
