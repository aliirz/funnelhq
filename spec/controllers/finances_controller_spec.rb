require 'spec_helper'

describe FinancesController do
  
  before :each do
    login_user
  end
  
  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

end
