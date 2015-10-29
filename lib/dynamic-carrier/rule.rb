module DynamicCarrier
  class Rule
    @@rules = []

    attr_accessor :delivery_method, :rule

    def initialize(delivery_method, rule)
      self.delivery_method = delivery_method
      self.rule = rule
    end

    def match(to, sms)
      if rule.is_a? Proc
        rule.call(to, sms)
      else
        rule.new.match(to, sms)
      end
    end

    def self.match(to, sms)
      @@rules.each do |rule|
        return rule.delivery_method if rule.match(to, sms)
      end
      false
    end

    def self.add(delivery_method, rule)
      @@rules << Rule.new(delivery_method, rule)
    end
  end
end
