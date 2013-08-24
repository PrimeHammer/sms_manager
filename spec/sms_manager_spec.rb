require 'spec_helper.rb'

describe SmsManager do
  describe 'configuration' do
    it "should set configuration vars" do
      SmsManager.configure do |config|
        config.username = "U"
        config.hashed_password = "H"
      end
      expect(SmsManager.instance_variable_get(:@username)).to eq("U")
      expect(SmsManager.instance_variable_get(:@hashed_password)).to eq("H")
    end
  end
end
