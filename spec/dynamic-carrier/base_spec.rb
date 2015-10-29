require 'spec_helper'

describe DynamicCarrier::Base do
  before { DynamicCarrier.add_rule(:china, Proc.new { |to, sms| to.start_with?('+86') }) }
  after { DynamicCarrier::Rule.class_variable_get(:@@rules).clear }
  let(:sms) { SmsCarrier::Base.sms(message) }

  describe ".deliver!" do
    context "when +86" do
      let(:message) { { :to => '+8615123456789', :body => '' } }
      after { sms.deliver_now }
      it { expect_any_instance_of(ChinaCarrier).to receive(:deliver!) }
      it { expect_any_instance_of(GlobalCarrier).not_to receive(:deliver!) }
    end

    context "when not +86" do
      let(:message) { { :to => '+886912345678', :body => '' } }
      after { sms.deliver_now }
      it { expect_any_instance_of(ChinaCarrier).not_to receive(:deliver!) }
      it { expect_any_instance_of(GlobalCarrier).to receive(:deliver!) }
    end

    context "when mixed" do
      let(:message) { { :to => ['+8615123456789', '+886912345678'], :body => '' } }
      after { sms.deliver_now }
      it { expect_any_instance_of(ChinaCarrier).to receive(:deliver!) }
      it { expect_any_instance_of(GlobalCarrier).to receive(:deliver!) }
    end

    context "when default_delivery_method is nil and not match" do
      before { SmsCarrier::Base.dynamic_settings[:default_delivery_method] = nil }
      let(:message) { { :to => '+886912345678', :body => '' } }
      after { sms.deliver_now }
      it { expect_any_instance_of(ChinaCarrier).not_to receive(:deliver!) }
      it { expect_any_instance_of(GlobalCarrier).not_to receive(:deliver!) }
      it { expect_any_instance_of(SmsCarrier::TestCarrier).to receive(:deliver!) }
    end

    context "when default_delivery_method is :dynamic and not match" do
      before { SmsCarrier::Base.dynamic_settings[:default_delivery_method] = :dynamic }
      let(:message) { { :to => '+886912345678', :body => '' } }
      after { sms.deliver_now }
      it { expect_any_instance_of(ChinaCarrier).not_to receive(:deliver!) }
      it { expect_any_instance_of(GlobalCarrier).not_to receive(:deliver!) }
      it { expect_any_instance_of(SmsCarrier::TestCarrier).to receive(:deliver!) }
    end
  end
end
