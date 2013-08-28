require "sms_manager/error/sending_error"
require "httpclient"

module SmsManager

  class Client
    # options should be { number: String, message: String }
    def send_message(options = {})
      validate_send_message_options! options
      options = {
        username: SmsManager.instance_variable_get(:@username),
        password: SmsManager.instance_variable_get(:@hashed_password),
        number: options[:number],
        message: options[:message]
      }
      body = HTTPClient.get('http://http-api.smsmanager.cz/Send', options).body
      unless body =~ /^OK/
        raise SendingError.new(options, body)
      end
      nil
    end

    private

    def validate_send_message_options!(options)
      options.each do |option, value|
        unless value.is_a?(String)
          raise ArgumentError, "Invalid #{option} specified: #{value} must be a string."
        end
      end
    end
  end
end