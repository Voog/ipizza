require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Ipizza::Provider::Nordea do
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
      opts[:return_url] = 'http://return.url'
      req.request_params['RETURN'].should eq('http://return.url')
    end

    it 'uses default return_url param when not specified' do
      req.request_params['RETURN'].should eq(described_class.payments_return_url)
    end

    it 'accepts cancel_url param' do
      opts[:cancel_url] = 'http://cancel.url'
      req.request_params['CANCEL'].should eq('http://cancel.url')
    end

    it 'uses default cancel_url param when not specified' do
      req.request_params['CANCEL'].should eq(described_class.payments_cancel_url)
    end
  end

  describe '#authentication_request' do
    before(:each) do
      @req = provider.authentication_request
    end

    it 'returns signed authentication request object' do
      @req.request_params.fetch('A01Y_MAC').should be
    end

    it 'adds service url to request' do
      @req.service_url.should == Ipizza::Provider::Nordea.auth_service_url
    end

    it 'adds return url from configuration to request' do
      @req.request_params.fetch('A01Y_RETLINK').should == Ipizza::Provider::Nordea.auth_return_url
    end

    it 'adds cancel url from configuration to request' do
      @req.request_params.fetch('A01Y_CANLINK').should == Ipizza::Provider::Nordea.auth_cancel_url
    end

    it 'adds reject url from configuration to request' do
      @req.request_params.fetch('A01Y_REJLINK').should == Ipizza::Provider::Nordea.auth_reject_url
    end
  end
end
