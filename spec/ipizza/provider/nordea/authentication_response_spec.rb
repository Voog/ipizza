require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe Ipizza::Provider::Nordea::AuthenticationResponse do
  before(:each) do
    @valid_params = {
      "B02K_CUSTNAME" => "Demo kasutaja", "B02K_IDNBR" => "87654321", "B02K_TIMESTMP" => "20020101204145428720",
      "B02K_STAMP" => "20101204155339", "B02K_KEYVERS" => "0001", "B02K_MAC" => "A061E22312D7D63FDC2B0B52E16BC971",
      "B02K_CUSTTYPE" => "01", "B02K_ALG" => "01", "B02K_CUSTID" => "37404280367", "B02K_VERS" => "0002"
    }
  end
  
  describe '#valid?' do
    context 'given valid parameters' do
      it 'returns true' do
        @response = Ipizza::Provider::Nordea::AuthenticationResponse.new(@valid_params)
        @response.verify(Ipizza::Provider::Nordea.file_key)
        @response.valid?.should be_true
      end
    end
  end
  
  describe '#user_info' do
    before(:each) do
      @response = Ipizza::Provider::Nordea::AuthenticationResponse.new(@valid_params)
    end
    
    context 'given valid parameters' do
      before(:each) do
        @response.verify(Ipizza::Provider::Nordea.file_key)
      end
      
      it 'returns hash containing user name' do
        @response.user_info.fetch('name').should == 'Demo kasutaja'
      end
      
      it 'returns hash containing user id' do
        @response.user_info.fetch('custid').should == '37404280367'
      end
    end
  end
end
