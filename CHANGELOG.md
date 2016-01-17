0.1.0
-----
* Initial release

0.2.0
-----
* backward incompatible change: renamed `send_message` to `send`
* code refactor

0.2.1
-----
* Add `send_message` back to keep backward compatibility

0.3.0
-----
* remove `code` attribute from `SmsManager::SendingError`
* Made changes so that you don't need to rescue `HTTPClient` exceptions. Rescue only `SmsManager::SendingError`

```ruby
begin
  SmsManager.send number: '+420123456789', message: 'Hello!'
rescue SmsManager::Error => e
  puts e.message # => Neplatný parametr gateway
end
```