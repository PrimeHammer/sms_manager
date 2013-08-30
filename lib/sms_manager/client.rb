require "sms_manager/error/sending_error"
require "httpclient"
require "sms_manager/send_params"

module SmsManager

  class Client
    # options should be { number: String, message: String }
    def send_message(options = {})
      options = {
        username: SmsManager.instance_variable_get(:@username),
        password: SmsManager.instance_variable_get(:@hashed_password),
        number: options[:number],
        message: options[:message]
      }
      validate_send_message_options! options
      body = HTTPClient.get('http://http-api.smsmanager.cz/Send', options).body
      unless body =~ /^OK/
        raise SendingError.new(options, body)
      end
      nil
    end

    private

    def validate_send_message_options!(options)
      params = SendParams.new(options)
      raise ConfigurationError unless params.valid?
    end
  end
end