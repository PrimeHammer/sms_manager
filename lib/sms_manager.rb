require 'sms_manager/error/sending_error'
require 'httpclient'

module SmsManager
  class << self
    attr_writer :username, :hashed_password

    def configure
      yield self
    end

    # options should be { number: String, message: String }
    def send(options = {})
      options = {
        username: SmsManager.instance_variable_get(:@username),
        password: SmsManager.instance_variable_get(:@hashed_password),
        number: options[:number],
        message: options[:message]
      }
      body = HTTPClient.get('http://http-api.smsmanager.cz/Send', options).body
      raise SendingError.new(options, body) unless body =~ /^OK/
    end
  end
end