require "simplecov"
require "coveralls"
SimpleCov.start

require "webmock/rspec"
require "sms_manager"

WebMock.disable_net_connect!
