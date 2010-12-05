require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe Ipizza::Provider::Nordea::AuthenticationResponse do
  before(:each) do
    @valid_params = {
      "B02K_CUSTNAME" => "Demo kasutaja", "B02K_IDNBR" => "87654321", "B02K_TIMESTMP" => "20020101204145428720",
      "B02K_STAMP" => "20101204155339", "B02K_KEYVERS" => "0001", "B02K_MAC" => "A061E22312D7D63FDC2B0B52E16BC971",
      "B02K_CUSTTYPE" => "01", "B02K_ALG" => "01", "B02K_CUSTID" => "37404280367", "B02K_VERS" => "0002"
    }
    @response = Ipizza::Provider::Nordea::AuthenticationResponse.new(@valid_params)
    @response.verify(Ipizza::Provider::Nordea.file_key)
  end
  
  describe '#valid?' do
    context 'given valid parameters' do
      it 'returns true' do
        @response.valid?.should be_true
      end
    end
  end
  
  describe '#info_social_security_id' do
    it 'should get user social security id from the response' do
      @response.info_social_security_id.should == '37404280367'
    end
  end
  
  describe '#info_name' do
    it 'should get user name from the response' do
      @response.info_name.should == 'Demo kasutaja'
    end
  end
end
