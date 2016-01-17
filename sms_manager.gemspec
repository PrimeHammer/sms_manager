# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sms_manager/version'

Gem::Specification.new do |gem|
  gem.name          = "sms_manager"
  gem.version       = SmsManager::Version
  gem.date          = '2016-01-18'
  gem.authors       = ["David Hrachovy"]
  gem.email         = ["david.hrachovy@gmail.com"]
  gem.description   = %q{Ruby SDK for smsmanager.cz API}
  gem.summary       = %q{SmsManager is a Ruby library for sending SMS messages by smsmanager.cz provider}
  gem.homepage      = "https://github.com/PrimeHammer/sms_manager"
  gem.required_ruby_version = '>= 2.0'
  gem.add_dependency  "httpclient", "~> 2.7.0"
  gem.add_development_dependency "bundler"
  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.license       = 'MIT'
end
