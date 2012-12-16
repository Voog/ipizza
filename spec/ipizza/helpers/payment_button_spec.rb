require 'spec_helper'

describe Ipizza::Helpers::PaymentButton do
  include ViewHelpers
  include described_class

  let(:payment) do
    Ipizza::Payment.new(
      :stamp => 1, :amount => '123.34', :refnum => 1,
      :message => 'Payment message', :currency => 'EUR'
    )
  end

  let(:opts) { {} }
  let(:result) { Nokogiri::HTML(payment_button(payment, :swedbank, opts)) }
  subject { result.css('form') }

  it { should include_field('VK_SERVICE') }
  it { should include_field('VK_VERSION') }
  it { should include_field('VK_SND_ID') }
  it { should include_field('VK_STAMP') }
  it { should include_field('VK_AMOUNT') }
  it { should include_field('VK_CURR') }
  it { should include_field('VK_REF') }
  it { should include_field('VK_MSG') }
  it { should include_field('VK_MAC') }
  it { should include_field('VK_CHARSET') }
  it { should include_field('VK_RETURN') }
  it { should include_field('VK_CANCEL') }

  it 'accepts return_url param' do
    opts[:return_url] = 'http://return.url'
    subject.should include_field('VK_RETURN', 'http://return.url')
  end

  it 'accepts cancel_url param' do
    opts[:cancel_url] = 'http://cancel.url'
    subject.should include_field('VK_CANCEL', 'http://cancel.url')
  end

  it 'has correct action' do
    Ipizza::Config.configure do |config|
      config.swedbank_service_url = 'http://bank.com'
    end

    action = subject.attribute('action').value
    action.should eq('http://bank.com')
  end

  it 'has a class with provider name' do
    subject.attribute('class').value.should eq('swedbank_payment')
  end

  it 'has a submit button' do
    button = subject.css('input[type=submit]')
    button.should_not be_empty
  end

  it 'accepts value' do
    opts[:value] = 'Pay with Swedbank'
    button = subject.css('input[type=submit]')
    button.attribute('value').value.should eq('Pay with Swedbank')
  end
end
