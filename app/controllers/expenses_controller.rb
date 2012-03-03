class ExpensesController < ApplicationController
   
  respond_to :html
  
  before_filter :find_expense, :only => [:show, :edit, :update, :destroy]
  
  def index
    @expenses = @user.expenses.all
    respond_with @expenses
  end

  def show
    respond_with @expense
  end
  
  def new
    @expense = @user.expenses.new 
    respond_with @expense
  end

  def edit
  end

  def create
    @expense = @user.expenses.new(params[:expense])

    respond_to do |format|
      if @expense.save
        format.html { redirect_to @expense, notice: 'Expense was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update

    respond_to do |format|
      if @expense.update_attributes(params[:expense])
        format.html { redirect_to @expense, notice: 'Expense was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @expense.destroy

    respond_to do |format|
      format.html { redirect_to expenses_url }
    end
  end
  
  private
  
  def find_expense
    @expense = @user.expenses.find(params[:id])
  end
end
