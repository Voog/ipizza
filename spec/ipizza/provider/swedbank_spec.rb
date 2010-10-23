require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Ipizza::Provider::Swedbank, 'payment_request' do
  
  before(:each) do
    @payment = Ipizza::Payment.new(:stamp => 1, :amount => '123.34', :refnum => 1, :message => 'Payment message', :currency => 'EUR')
  end
  
  it 'should sign the request' do
    req = Ipizza::Provider::Swedbank.new.payment_request(@payment)
    req.sign_params['VK_MAC'].should == 'aVCFvsLJiczQw9VoYMdtoQKj5fXkP8OI+JfQN8bFGKZGxC/X5gVIIi/Bh9AyB6JXwbeMOfUlnvuJIukpmBpDg3dEWkv4xGwKdfacqwYkgSC17OBb7VmZ+B4d6HYaO088wxH1FBSVa87HKFJ7ScTEJfd3ZEZly9WzTPHiFWvpRGDxAYtuO5nfGMcscxOQ0B0cbrIcLKvqLho25hIgns3+lvRDWsOb9lFH//7U8OBOC9SuXCBwvC4Fng3wqmBSKRJgAqvQ40Y4XpBGt3U/ix26Vs1cP8lOGHUyqzrqKbcmvqqhgWzqpa0JoK6im/MhBePyNnHVoC8Pqw4ZwZb4YrrPXw=='
  end
end

describe Ipizza::Provider::Swedbank, 'payment_response' do
  
  it 'should parse and verify the payment response from bank'
  
end
