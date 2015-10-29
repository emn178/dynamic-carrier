class GlobalCarrier < SmsCarrier::TestCarrier
end
SmsCarrier::Base.add_delivery_method :global, GlobalCarrier
