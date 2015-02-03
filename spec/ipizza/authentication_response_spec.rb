require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Ipizza::AuthenticationResponse do
  before(:each) do
    @resp = Ipizza::AuthenticationResponse.new('VK_USER_NAME' => 'tõõger , LeõpäöldžŽšŠ', 'VK_USER_ID' => '35511280268')
  end

  describe '#info_social_security_id' do
    it 'should get user social security id from the response' do
      @resp.info_social_security_id.should == '35511280268'
    end
  end

  describe '#info_name' do
    it 'should get user name from the response' do
      @resp.info_name.should == 'tõõger , LeõpäöldžŽšŠ'
    end
  end

  describe '#authentication_info' do
    it 'should return Ipizza::Authentication object' do
      @resp.authentication_info.should be_a(Ipizza::Authentication)
    end
  end
end
