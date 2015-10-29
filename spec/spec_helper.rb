require 'simplecov'
require 'coveralls'

SimpleCov.add_filter "/spec/"

if ENV["COVERAGE"]
  SimpleCov.start
elsif ENV["COVERALLS"]
  SimpleCov.formatter = Coveralls::SimpleCov::Formatter
  Coveralls.wear!
end

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'dynamic-carrier'
require 'rspec/its'

Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each do |file|
  require file
end

SmsCarrier::Base.delivery_method = :dynamic
SmsCarrier::Base.dynamic_settings = {
  :default_delivery_method => :global
}
SmsCarrier::Base.logger = Logger.new(nil)
