require 'sms_manager/configurable'
require "sms_manager/client"

module SmsManager
  class << self
    include Configurable

    # delegate calls to client
    def client
      return @client if instance_variable_defined?(:@client)
      @client = SmsManager::Client.new
    end

    def method_missing(method_name, *args, &block)
      return super unless respond_to_missing?(method_name)
      client.send(method_name, *args, &block)
    end

    def respond_to_missing?(method_name, include_private=false)
      client.respond_to?(method_name, include_private)
    end

  end
end