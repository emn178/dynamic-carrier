require 'spec_helper'

describe DynamicCarrier::Rule do
  after { DynamicCarrier::Rule.class_variable_get(:@@rules).clear }
  subject { rule }

  describe ".match" do
    context "when Proc" do
      let(:rule) { DynamicCarrier::Rule.new :test, Proc.new { |to, sms| to } }
      it { expect(subject.match(true, nil)).to eq true }
      it { expect(subject.match(false, nil)).to eq false }
    end

    context "when Class" do
      let(:rule) { DynamicCarrier::Rule.new :test, TestRule }
      it { expect(subject.match(true, nil)).to eq true }
      it { expect(subject.match(false, nil)).to eq false }
    end
  end

  describe "#match" do
    context "when Proc" do
      before { 
        DynamicCarrier::Rule.add(:rule, Proc.new { |to, sms| to })
        DynamicCarrier::Rule.add(:rule2, Proc.new { |to, sms| sms })
      }
      it { expect(DynamicCarrier::Rule.match(true, false)).to eq :rule }
      it { expect(DynamicCarrier::Rule.match(false, true)).to eq :rule2 }
      it { expect(DynamicCarrier::Rule.match(false, false)).to eq false }
    end
  end
end
