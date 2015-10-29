require "sms_carrier"
require "dynamic-carrier/version"
# require "dynamic-carrier/log_subscriber"
require "dynamic-carrier/base"
require "dynamic-carrier/rule"

module DynamicCarrier
  def self.add_rule(delivery_method, rule)
    Rule.add(delivery_method, rule)
  end

  SmsCarrier::Base.add_delivery_method :dynamic, Base
end
