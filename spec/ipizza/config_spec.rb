require 'tempfile'
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Ipizza::Config do
  describe '.load_from_file' do

    before(:each) do
      Ipizza::Config.load_from_file(File.expand_path(File.dirname(__FILE__) + '/../config/plain_config.yml'))
    end
    
    it 'should load configuration from yml file' do
      Ipizza::Provider::Swedbank.service_url.should == 'https://www.swedbank.ee/banklink'
      Ipizza::Provider::Swedbank.return_url.should == 'http://test.local/return'
      Ipizza::Provider::Swedbank.cancel_url.should == 'http://test.local/cancel'
      Ipizza::Provider::Swedbank.key_secret.should == 'foobar'
      Ipizza::Provider::Swedbank.snd_id.should == 'dealer'
      Ipizza::Provider::Swedbank.encoding.should == 'ISO-8859-4'
      
      Ipizza::Provider::Seb.service_url.should == 'https://www.seb.ee/banklink'
    end
  
    it 'should load certificates from path relative to configuration file' do
      Ipizza::Provider::Swedbank.file_key.should == File.expand_path(File.dirname(__FILE__) + '/../certificates/dealer.key')
      Ipizza::Provider::Swedbank.file_cert.should == File.expand_path(File.dirname(__FILE__) + '/../certificates/bank.pub')
    end
    
    it 'should load certificates from absolute file paths' do
      cfg = {'swedbank' => YAML::load_file(File.expand_path(File.dirname(__FILE__) + '/../config/config.yml'))['swedbank']}
      cfg['swedbank']['file_key'] = File.expand_path(File.dirname(__FILE__) + '/../certificates/dealer.key')
      cfg['swedbank']['file_cert'] = File.expand_path(File.dirname(__FILE__) + '/../certificates/bank.pub')
      
      Tempfile::open('config.yml') do |tmp|
        tmp << cfg.to_yaml
        tmp.flush
        
        config = Ipizza::Config.load_from_file(File.expand_path(tmp.path))
        
        Ipizza::Provider::Swedbank.file_key.should == File.expand_path(File.dirname(__FILE__) + '/../certificates/dealer.key')
        Ipizza::Provider::Swedbank.file_cert.should == File.expand_path(File.dirname(__FILE__) + '/../certificates/bank.pub')
      end
    end
  end

  describe '.configure' do
    it 'changes the configuration inside block' do
      Ipizza::Config.configure do |c|
        c.swedbank_service_url = 'http://foo.bar/swedbank'
      end
      
      Ipizza::Provider::Swedbank.service_url.should == 'http://foo.bar/swedbank'
    end
    
    it 'should raise an error if configuration parameter does not exist' do
      lambda { Ipizza::Config.configure { |c| c.swedbank_unknown_attr = 'foo' } }.should raise_error
      lambda { Ipizza::Config.configure { |c| c.spermbank_service_url = 'foo' } }.should raise_error
    end
  end
end
