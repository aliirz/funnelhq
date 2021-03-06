class Invoice
  
  include Mongoid::Document
  include Mongoid::MultiParameterAttributes
  
  STATUS = %w(draft sent paid unpaid).map{|status| status.downcase}
  
  before_save :calculate_invoice_total
  
  ## fields ##
  
  field :invoice_id, :type => Integer
  field :client_id, :type => Integer
  field :date, :type => Date
  field :total, :type => Integer
  field :status, :type => String, :default => STATUS.first
  
  ## associations ##

  embedded_in :user, :inverse_of => :invoices
  
  embeds_many :line_items
  
  accepts_nested_attributes_for :line_items
  
  ## validations ##
  
  validate :limit_not_exceeded
    
  validates_associated :line_items
  
  ## scope ##

  scope :within_range, lambda { |x, y|
    where(:date => {'$gte' => x,'$lt' => y})
  }

  ## methods ##
  
  # Define some helper method for invoice statuses
  # e.g Invoice.sent?
  #
  # @param 
  # @return []
  
  STATUS.each do |_status|
    define_method("#{_status}?") do
      self.status == _status
    end
  end
  
  # Calculates the total value of all line items for an invoice
  #
  # @param 
  # @return [ Integer ] the sum of all line items
  
  def calculate_invoice_total
    res = [ ]
    self.line_items.each do |item|
      res.push(item.qty * item.price)
    end
    # Return the sum of the items
    self.total = res.inject(:+)    
  end
  
  # Return an array of month names i.e [jan, feb, march] etc
  #
  # @param 
  # @return [ Integer ] the sum of all line items
  
  def months_as_array
    (1..12).map {|m| [Date::MONTHNAMES[m]]}
  end
  
  private
  
  def limit_not_exceeded
    msg = 'You can\'t add any more invoices on this plan.'
    errors.add(:invoice, msg) if @user.invoice_limit_reached?
  end
end