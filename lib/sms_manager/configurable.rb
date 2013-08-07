require "sms_manager/error/configuration_error"

module SmsManager
  module Configurable
    attr_writer :username, :hashed_password

    def configure
      yield self
      validate_credential_type!
      self
    end

    private

    def credentials
      {
        :username    => @username,
        :hashed_password => @hashed_password,
      }
    end

    def validate_credential_type!
      credentials.each do |credential, value|
        unless value.is_a?(String)
          raise ConfigurationError, "Invalid #{credential} specified: #{value} must be a string."
        end
      end
    end
  end
end
