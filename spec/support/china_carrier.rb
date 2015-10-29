class ChinaCarrier < SmsCarrier::TestCarrier
  def deliver!(sms)
    super(sms)
  end
end
SmsCarrier::Base.add_delivery_method :china, ChinaCarrier
