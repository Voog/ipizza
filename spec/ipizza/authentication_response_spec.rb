require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Ipizza::AuthenticationResponse do
  
  before(:each) do
    @resp1 = Ipizza::AuthenticationResponse.new({'VK_INFO' => 'NIMI:tõõger , LeõpäöldžŽšŠ;ISIK:35511280268'})
    @resp2 = Ipizza::AuthenticationResponse.new({'VK_INFO' => 'ISIK:35511280268;NIMI:tõõger , LeõpäöldžŽšŠ'})
  end
  
  describe '#info_social_security_id' do
    it 'should get user social security id from the response' do
      @resp1.info_social_security_id.should == '35511280268'
      @resp2.info_social_security_id.should == '35511280268'
    end
  end
  
  describe '#info_name' do
    it 'should get user name from the response' do
      @resp1.info_name.should == 'tõõger , LeõpäöldžŽšŠ'
      @resp2.info_name.should == 'tõõger , LeõpäöldžŽšŠ'
    end
  end
end
