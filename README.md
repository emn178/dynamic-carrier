# dynamic-carrier

[![Build Status](https://api.travis-ci.org/emn178/dynamic-carrier.png)](https://travis-ci.org/emn178/dynamic-carrier)
[![Coverage Status](https://coveralls.io/repos/emn178/dynamic-carrier/badge.svg?branch=master)](https://coveralls.io/r/emn178/dynamic-carrier?branch=master)

An [sms_carrier](https://github.com/emn178/sms_carrier) delivery method layer that decides the delivery method dynamically by your rules.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dynamic-carrier'
```

And then execute:

    bundle

Or install it yourself as:

    gem install dynamic-carrier

## Usage
### Setup
Set up delivery method and Twilio settings in you rails config, eg. `config/environments/production.rb`
```Ruby
config.sms_carrier.delivery_method = :dynamic
config.sms_carrier.dynamic_settings = {
  # default delivery_method if not matched, default is :test
  :default_delivery_method => :twilio
}
```

### Rules
Add your rules by `DynamicCarrier.add_rule`.
```Ruby
# add a rule with Proc, it will use yunpian delivery_method if matched.
DynamicCarrier.add_rule(:yunpian, Proc.new { |to, sms| to.start_with?('+86') })

# This will send by yunpian
SmsCarrier::Base.sms(:to => '+8615123456789', :body => '...')

# This will send by your default_delivery_method, eg. twilio
SmsCarrier::Base.sms(:to => '+886912345678', :body => '...')
```
Or you can define a class.
```Ruby
class ChinaRule
  def match(to, sms)
    to.start_with?('+86')
  end
end

DynamicCarrier.add_rule(:yunpian, ChinaRule)
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Contact
The project's website is located at https://github.com/emn178/dynamic-carrier  
Author: emn178@gmail.com
