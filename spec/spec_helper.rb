require 'webmock/rspec'
require 'simplecov'
require 'coveralls'
require 'sms_manager'

SimpleCov.formatters = [SimpleCov::Formatter::HTMLFormatter, Coveralls::SimpleCov::Formatter]
SimpleCov.start

WebMock.disable_net_connect!