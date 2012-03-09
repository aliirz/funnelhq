class FinancesController < ApplicationController
  
  respond_to :html
  
  def index
    @invoices = @user.invoices.page(params[:page]).per(5)
    respond_with @invoice
  end
end