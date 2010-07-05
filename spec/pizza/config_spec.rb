require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Pizza::Config, 'load_from_file' do

  before(:each) do
    Pizza::Config.load_from_file(File.expand_path(File.dirname(__FILE__) + '/../config/plain_config.yml'))
  end
  
  it 'should load configuration from yml file' do
    Pizza::Provider::Swedbank.service_url.should == 'https://www.swedbank.ee/banklink'
    Pizza::Provider::Swedbank.return_url.should == 'http://test.local/return'
    Pizza::Provider::Swedbank.cancel_url.should == 'http://test.local/cancel'
    Pizza::Provider::Swedbank.key_secret.should == 'foobar'
    Pizza::Provider::Swedbank.snd_id.should == 'dealer'
    Pizza::Provider::Swedbank.encoding.should == 'ISO-8859-4'
    
    Pizza::Provider::Seb.service_url.should == 'https://www.seb.ee/banklink'
  end
  
  it 'should throw an error when certificate file does not exist'
  
  it 'should accept environment-based configuration file'

  it 'should load certificates from path relative to configuration file' do
    Pizza::Provider::Swedbank.file_key.should == File.expand_path(File.dirname(__FILE__) + '/../certificates/dealer.key')
    Pizza::Provider::Swedbank.file_cert.should == File.expand_path(File.dirname(__FILE__) + '/../certificates/bank.pub')
  end
  
  it 'should load certificates from absolute file paths'
end

describe Pizza::Config, 'configure' do
  it 'should change the configuration' do
    Pizza::Config.configure do |c|
      c.swedbank_service_url = 'http://foo.bar/swedbank'
    end
    
    Pizza::Provider::Swedbank.service_url.should == 'http://foo.bar/swedbank'
  end
  
  it 'should raise an error if configuration parameter does not exist' do
    lambda { Pizza::Config.configure { |c| c.swedbank_unknown_attr = 'foo' } }.should raise_error
    lambda { Pizza::Config.configure { |c| c.spermbank_service_url = 'foo' } }.should raise_error
  end
end
