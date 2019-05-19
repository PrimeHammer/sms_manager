require 'simplecov'
require 'coveralls'
SimpleCov.start
Coveralls.wear!

require 'webmock/rspec'
require 'sms_manager'

WebMock.disable_net_connect!