require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Pizza::Provider::Swedbank do
  before(:each) do
    @payment = Pizza::Payment.new(:stamp => 1, :amount => '123.34', :refnum => 1, :message => 'Payment message', :currency => 'EUR')
  end
  
  it 'should sign' do
    Pizza::Provider::Swedbank.service_url = 'http://service.local'
    Pizza::Provider::Swedbank.return_url = 'http://test.local/return'
    Pizza::Provider::Swedbank.cancel_url = 'http://test.local/cancel'
    Pizza::Provider::Swedbank.key = File.expand_path(File.dirname(__FILE__) + '/../../certificates/dealer.key')
    Pizza::Provider::Swedbank.key_secret = 'foobar'
    Pizza::Provider::Swedbank.cert = File.expand_path(File.dirname(__FILE__) + '/../../certificates/bank.pub')
    Pizza::Provider::Swedbank.snd_id = 'sender'
    Pizza::Provider::Swedbank.encoding = 'ISO-8859-4'
    
    req = Pizza::Provider::Swedbank.new.payment_request(@payment)
    req.sign_params['VK_MAC'].should == 'aVCFvsLJiczQw9VoYMdtoQKj5fXkP8OI+JfQN8bFGKZGxC/X5gVIIi/Bh9AyB6JXwbeMOfUlnvuJIukpmBpDg3dEWkv4xGwKdfacqwYkgSC17OBb7VmZ+B4d6HYaO088wxH1FBSVa87HKFJ7ScTEJfd3ZEZly9WzTPHiFWvpRGDxAYtuO5nfGMcscxOQ0B0cbrIcLKvqLho25hIgns3+lvRDWsOb9lFH//7U8OBOC9SuXCBwvC4Fng3wqmBSKRJgAqvQ40Y4XpBGt3U/ix26Vs1cP8lOGHUyqzrqKbcmvqqhgWzqpa0JoK6im/MhBePyNnHVoC8Pqw4ZwZb4YrrPXw=='
  end
end