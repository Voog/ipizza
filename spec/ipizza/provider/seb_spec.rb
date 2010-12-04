require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Ipizza::Provider::Seb do
  describe '#payment_request' do
  
    before(:each) do
      @payment = Ipizza::Payment.new(:stamp => 1, :amount => '123.34', :refnum => 1, :message => 'Payment message', :currency => 'EUR')
    end
    
    it 'should sign the request' do
      req = Ipizza::Provider::Seb.new.payment_request(@payment)
      req.sign_params['VK_MAC'].should == 'aVCFvsLJiczQw9VoYMdtoQKj5fXkP8OI+JfQN8bFGKZGxC/X5gVIIi/Bh9AyB6JXwbeMOfUlnvuJIukpmBpDg3dEWkv4xGwKdfacqwYkgSC17OBb7VmZ+B4d6HYaO088wxH1FBSVa87HKFJ7ScTEJfd3ZEZly9WzTPHiFWvpRGDxAYtuO5nfGMcscxOQ0B0cbrIcLKvqLho25hIgns3+lvRDWsOb9lFH//7U8OBOC9SuXCBwvC4Fng3wqmBSKRJgAqvQ40Y4XpBGt3U/ix26Vs1cP8lOGHUyqzrqKbcmvqqhgWzqpa0JoK6im/MhBePyNnHVoC8Pqw4ZwZb4YrrPXw=='
    end
  end

  describe '#payment_response' do
    it 'should parse and verify the payment response from bank'
  end

  describe '#authentication_request' do
    before(:each) do
      Time.stub!(:now).and_return(Time.parse('Mar 30 1981'))
      Date.stub!(:today).and_return(Date.parse('Mar 30 1981'))
    end
    
    it 'should sign the request' do
      req = Ipizza::Provider::Seb.new.authentication_request
      req.sign_params['VK_MAC'].should == '0ZBLzC3XddTNZ4YBNJlPsJ/RDK4g7Utot9L3lvaxD9J0dfKfN4FUnife3oAQjhyc8lOi5MeBdjekN5mW7KXEMcOSTR9kCJTLZcJg1nMHTDjZcLu9FTAk2wcSrc8kUgigh22vBA38wQfbsZvong5ETYanH8RchZUp72tmO2rFmKzdD8bsnubg6l3m5NxoFv+2F6RsxzwtpkCNaKBpIH4iyWIYFWX7H3hTiUWlAXwKp8GP8OYPr1wUDbP2jVxOwpv7MW3g/heKfu3INBSazsvD22WhsNeKPKmqjJDIiJvo5QRhYq5Shze28oWQyCixMfw2UW7pk0gOtYJkrlwEEo22zQ=='
    end
  end

  describe '#authentication_response' do
    before(:each) do
      @params = {
        'VK_TIME' => '00:56:37', 'VK_USER' => '', 'VK_INFO' => 'NIMI:tõõger , LeõpäöldžŽšŠ;ISIK:35511280268',
        'VK_DATE' => '24.10.2010', 'VK_CHARSET' => 'UTF-8', 'VK_RETURN' => 'http://rkas-aktide-is.local/ipizza/auth',
        'VK_LANG' => 'EST', 'VK_SERVICE'=>'3002', 'VK_RID' => '', 'VK_SND_ID' => 'EYP', 'VK_VERSION' => '008',
        'VK_MAC' => 'BeYfkTTj9HNCoMSVbBHSYujFpdcPfo3Ee56ZwaHzYwLj3/QMsb3b5cA7Z1GjeW2VLIoWVtOZmjWN9N74NtH7mu0Nv3RUYep6DJcsZvejs9uklpCLFS1bzInGlQKh3Q04Vttss6dLxgoRJu7lT3hvPKUPHtBZ2RZMHByLuwqNqC4='
      }
    end
    
    it 'should parse and verify the authentication response from bank' do
      Ipizza::Provider::Seb.new.authentication_response(@params).should be_valid
    end
  end
end