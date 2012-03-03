class Expense
  
  include Core::Mongoid::Document

  field :expense, :type => String
  field :amount, :type => Integer
  field :date, :type => Date
  
  ## associations ##
  
  embedded_in :user, :inverse_of => :expenses
  
  ## validations ##
  
  validates_presence_of :expense
  validates_presence_of :amount
  
  ## scope ##

  scope :within_range, lambda { |x, y|
    where(:updated_at => {'$gte' => x,'$lt' => y})
  }
  
  ## methods ##
    
end
