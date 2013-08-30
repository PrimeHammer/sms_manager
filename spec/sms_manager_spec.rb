# encoding: utf-8
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

  describe 'sending' do
    it "should work" do
      SmsManager.configure do |config|
        config.username = "david.hrachovy@gmail.com"
        config.hashed_password = "b4b976b7217ac3e336d9249ee15a3fc21fc69ce1"
      end
      VCR.use_cassette('valid') do
        expect { SmsManager.send_message number: '+420605348034', message: 'Hello!' }.not_to raise_error
      end
    end
    it "should raise exception with code and message" do
      SmsManager.configure do |config|
        config.username = "U"
        config.hashed_password = "H"
      end
      VCR.use_cassette('valid') do
        expect { SmsManager.send_message number: '+420123456789', message: 'Hello!' }.to \
          raise_error(SmsManager::SendingError)  do |e|
            expect(e.code).to eq(103)
            expect(e.message).to eq("Neplatné uživatelské jméno nebo heslo")
          end
      end
    end
    it "should raise exception with invalid params" do
      SmsManager.configure do |config|
        config.username = "a"
        config.hashed_password = "a"
      end
      expect { SmsManager.send_message number: " ", message: "aa"}.\
        to raise_error(SmsManager::ConfigurationError)
    end
  end

  describe 'sending paramaters validations' do
    before(:each) do
      @default_params = { username: 'a', password: 'b', number: '123', message: 'hello' }
    end

    it "should be valid for username, password, number, message, otherwise not" do
      expect(SendParams.new(@default_params).valid?).to be_true
      expect(SendParams.new(username: 'a').valid?).to be_false
    end
  end
end
