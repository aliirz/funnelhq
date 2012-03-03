require "spec_helper"

describe UserMailer do
  
  let(:user) { Factory.create(:user) }
  
  describe "welcome_email" do
    it "should render successfully" do
      lambda { UserMailer.welcome_email(user) }.should_not raise_error
    end
  end
  
end
