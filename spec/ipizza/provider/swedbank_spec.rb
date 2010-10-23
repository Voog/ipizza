require 'time'
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

describe Ipizza::Provider::Swedbank, 'authentication_request' do
  before(:each) do
    Time.stub!(:now).and_return(Time.parse("Mar 30 1981"))
    Date.stub!(:today).and_return(Date.parse("Mar 30 1981"))
  end
  
  it 'should sign the request' do
    req = Ipizza::Provider::Swedbank.new.authentication_request
    req.sign_params['VK_MAC'].should == 'C9HV2e9IKnHcFGKjnDjx0caBMnhBtpXeZE8GOFD9Qph/KKO3eAJbMNDGJ7bOBFulot/rZVOVaqYIgTcGEfmg+FV7QgoyVwN5TBRJXdkvYo73qY8I71ONd/7lRrU+T/9b3nI+dRM3Y/D/DeMSe07/Ge9L/IDTnoloUefoOKIEGxmfr+zc0RzJ+S9nev8M+sepyA2LvbGGJKMAiraV/DpQeb3Xf8UnC7UihAjx9NtnXI5DY15YKDupj+FtwoQ4xGgV/M1Xy57XuDajnSU4wbTSqwomTE9PugpbZwqO9zbisMFA6H6PTWXn/henL8EM/D6BnL6DjsqmZlQSckabsNtuBQ=='
  end
end

describe Ipizza::Provider::Swedbank, 'authentication_response' do
  it 'should parse and verify the authentication response from bank'
end