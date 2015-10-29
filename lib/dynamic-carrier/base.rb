module DynamicCarrier
  class Base
    attr_accessor :settings

    def initialize(settings)
      self.settings = settings
    end

    def deliver!(sms)
      options = {:from => sms.from, :body => sms.body}.merge(sms.options)
      hash_to = {}
      sms.to.each do |to|
        delivery_method = DynamicCarrier::Rule.match(to, sms)
        delivery_method ||= settings[:default_delivery_method] || :test
        if delivery_method == :dynamic
          delivery_method = :test
          SmsCarrier::Base.logger.warn('default_delivery_method or rule delivery_method can not be :dynamic')
        end
        hash_to[delivery_method] = [] unless hash_to[delivery_method]
        hash_to[delivery_method] << to
      end
      hash_to.each do |delivery_method, to|
        options[:delivery_method] = delivery_method
        options[:to] = to
        SmsCarrier::Base.sms(options).deliver_now
      end
    end
  end
end
