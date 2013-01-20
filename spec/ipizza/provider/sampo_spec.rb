require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Ipizza::Provider::Sampo do
  let(:provider) { described_class.new }

  describe '#payment_request' do
    let(:opts) { {} }
    let(:payment) do
      Ipizza::Payment.new(
        :stamp => 1, :amount => '123.34', :refnum => 1,
        :message => 'Payment message', :currency => 'EUR'
      )
    end
    let(:req) { provider.payment_request(payment, 1002, opts) }

    it 'accepts return_url param' do
      Ipizza::Util.stub(:sign) { 'stubbed' }
      opts[:return_url] = 'http://return.url'
      req.request_params['VK_RETURN'].should eq('http://return.url')
    end

    it 'uses default return_url param when not specified' do
      Ipizza::Util.stub(:sign) { 'stubbed' }
      req.request_params['VK_RETURN'].should eq(described_class.return_url)
    end
  end
end
