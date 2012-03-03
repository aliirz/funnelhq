require 'spec_helper'

describe ExpensesController do
  
  before :each do
    login_user
  end

  describe "GET index" do
    it "assigns all expenses as @expenses" do
      expense = Factory.create(:expense)
      get :index
      assigns(:expenses).should eq([expense])
    end
  end

  describe "GET show" do
    it "assigns the requested expense as @expense" do
      expense = Factory.create(:expense)
      get :show, :id => expense
      assigns(:expense).should eq(expense)
    end
  end

  describe "GET new" do
    it "assigns a new expense as @expense" do
      get :new
      assigns(:expense).should be_a_new(Expense)
    end
  end

  describe "GET edit" do
    it "assigns the requested expense as @expense" do
      expense = Factory.create(:expense)
      get :edit, :id => expense
      assigns(:expense).should eq(expense)
    end
  end
end
