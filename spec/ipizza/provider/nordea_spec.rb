require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Ipizza::Provider::Nordea do
  describe '#authentication_request' do
    before(:each) do
      @req = Ipizza::Provider::Nordea.new.authentication_request
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
