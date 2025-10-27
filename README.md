# SmsManager

[![Gem Version](https://badge.fury.io/rb/sms_manager.png)](http://badge.fury.io/rb/sms_manager)


A Ruby SDK for [smsmanager.cz](http://smsmanager.cz/) - Czech SMS provider.

## Installation

`gem install sms_manager`

Or add to Gemfile:

`gem 'sms_manager'`

## Usage

First you need to setup your credentials:

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
SmsManager.send number: '+420123456789', message: 'Hello!'
```

You can pass all the parameters available at [SmsManager API](http://smsmanager.cz/api/http/). These additional parameters will be appended to the request:

```ruby
SmsManager.send number: '+420123456789', message: 'Hello!', gateway: 'lowcost', time: '2013-01-01T23:59:59'
```

If the service fails an exception is raised:

```ruby
begin
  SmsManager.send number: '+420123456789', message: 'Hello!'
rescue SmsManager::Error => e
  puts e.message # => Neplatný parametr gateway
end
```

## Copyright

Copyright (c) 2013 David Hrachovy
See [LICENSE][] for details.

[license]: LICENSE.md
