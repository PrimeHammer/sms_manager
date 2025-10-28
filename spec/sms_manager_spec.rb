require 'spec_helper.rb'

describe SmsManager do
  it 'sets configuration vars' do
    SmsManager.configure do |config|
      config.username = 'U'
      config.hashed_password = 'H'
    end

    expect(SmsManager.instance_variable_get(:@username)).to eq('U')
    expect(SmsManager.instance_variable_get(:@hashed_password)).to eq('H')
  end

  describe 'send' do
    before do
      SmsManager.configure do |config|
        config.username = 'david@example.com'
        config.hashed_password = 'b4b976b7217ac3e336d9249ee15a3fc21fc69ce1'
      end
    end

    it 'uses configuration vars and send params in request' do
      stub_send.to_return body: 'OK'
      SmsManager.send number: '+420123456789', message: 'Hello!'

      expect(stub_send).to have_been_requested
    end

    it 'raises error with details if response body is not ok' do
      stub_send.to_return body: 'ERROR|103'

      expect { SmsManager.send number: '+420123456789', message: 'Hello!' }.to \
        raise_error(SmsManager::Error) do |e|
          expect(e.message).to eq('Neplatné uživatelské jméno nebo heslo (103)')
        end
    end

    it 'raises SmsManager error if HTTP request fails' do
      expect(HTTPClient).to receive(:get).and_raise HTTPClient::ConnectTimeoutError.new('oops')

      expect { SmsManager.send number: '+420123456789', message: 'Hello!' }.to \
        raise_error(SmsManager::Error) do |e|
          expect(e.message).to eq('oops')
        end
    end
  end

  describe 'send message' do
    before do
      SmsManager.configure do |config|
        config.username = 'david@example.com'
        config.hashed_password = 'b4b976b7217ac3e336d9249ee15a3fc21fc69ce1'
      end
    end

    it 'uses configuration vars and send params in request' do
      stub_send.to_return body: 'OK'
      SmsManager.send_message number: '+420123456789', message: 'Hello!'

      expect(stub_send).to have_been_requested
    end

    it 'raises error with details if response body is not ok' do
      stub_send.to_return body: 'ERROR|103'

      expect { SmsManager.send_message number: '+420123456789', message: 'Hello!' }.to \
        raise_error(SmsManager::Error) do |e|
          expect(e.message).to eq('Neplatné uživatelské jméno nebo heslo (103)')
        end
    end

    it 'raises SmsManager error if HTTP request fails' do
      expect(HTTPClient).to receive(:get).and_raise HTTPClient::ConnectTimeoutError.new('oops')

      expect { SmsManager.send_message number: '+420123456789', message: 'Hello!' }.to \
        raise_error(SmsManager::Error) do |e|
          expect(e.message).to eq('oops')
        end
    end
  end

  def stub_send
    stub_request(:get, 'http://http-api.smsmanager.cz/Send?message=Hello!&number=%2B420123456789&password=b4b976b7217ac3e336d9249ee15a3fc21fc69ce1&username=david@example.com')
  end
end
