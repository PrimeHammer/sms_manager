# SmsManager

[![Gem Version](https://badge.fury.io/rb/sms_manager.png)](http://badge.fury.io/rb/sms_manager)
[![Dependency Status](https://gemnasium.com/dayweek/sms_manager.png)](https://gemnasium.com/dayweek/sms_manager)
[![Code Climate](https://codeclimate.com/github/dayweek/sms_manager.png)](https://codeclimate.com/github/dayweek/sms_manager)

A Ruby SDK for [smsmanager.cz](http://smsmanager.cz/) - Czech SMS provider.

## Installation
    gem install sms_manager

Add this line to your application's Gemfile:

    gem 'sms_manager'

And then execute:

    bundle

Or install it yourself as:

    gem install sms_manager

## Usage

First you need to setup your credentials. This can be done only once:

```ruby
SmsManager.configure do |config|
  config.username = YOUR_USERNAME
  config.hashed_password = HASHED_PASSWORD
end
```

Create the password hash with SHA-1 in console and then put the string into the configuration block:

```ruby
require 'digest/sha1'
Digest::SHA1.hexdigest 'password'
```

That's all. Now you can send SMS messages.

```ruby
SmsManager.send_message number: '+420123456789', message: 'Hello!'
```

`number`, `message`, `username`, `hashed_password` are validated before sending the request. If validation fails `SmsManager::ConfigurationError` is raised. 

You can pass all the parameters available at [SmsManager API](http://smsmanager.cz/api/http/). However these additional parameters will not be validated and will be appended to the request:

```ruby
SmsManager.send_message number: '+420123456789', message: 'Hello!', gateway: 'lowcost', time: '2013-01-01T23:59:59'
```

If the service fails an exception is raised. The exception contains error code as well as error message.

```ruby
begin
  SmsManager.send_message number: '+420123456789', message: 'Hello!'
rescue SmsManager::SendingError => e
  puts e.code
  puts e.message
end
```

## Background call

If you do not want to block your app you can use `sucker_punch` to delegate the method call to a pool of workers. Note that any raised exception is not propagated to you, it's _fire and forget_.

```ruby
module SmsManager
  class Client
    include SuckerPunch::Job
  end
end

SmsManager.configure do |config|
  config.username = YOUR_USERNAME
  config.hashed_password = HASHED_PASSWORD
end

SmsManager.async.send_message number: '+420123456789', message: 'Hello!'
```

## Copyright

Copyright (c) 2013 David Hrachovy
See [LICENSE][] for details.

[license]: LICENSE.md
