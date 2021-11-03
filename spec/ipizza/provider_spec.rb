require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Ipizza::Provider do
  describe '.get' do
    it 'returns LHV provider for "lhv" attribute' do
      Ipizza::Provider.get('lhv').should be_a(Ipizza::Provider::Lhv)
    end

    it 'returns swedbank provider for "swedbank" attribute' do
      Ipizza::Provider.get('swedbank').should be_a(Ipizza::Provider::Swedbank)
    end

    it 'returns swedbank provider for "hp" attribute' do
      Ipizza::Provider.get('hp').should be_a(Ipizza::Provider::Swedbank)
    end

    it 'returns seb provider for "eyp" attribute' do
      Ipizza::Provider.get('eyp').should be_a(Ipizza::Provider::Seb)
    end

    it 'returns seb provider for "seb" attribute' do
      Ipizza::Provider.get('seb').should be_a(Ipizza::Provider::Seb)
    end

    it 'returns luminor provider for "luminor" attribute' do
      Ipizza::Provider.get('luminor').should be_a(Ipizza::Provider::Luminor)
    end

    it 'returns luminor provider for "testluminor" attribute' do
      Ipizza::Provider.get('luminor').should be_a(Ipizza::Provider::Luminor)
    end

    it 'returns sampo provider for "sampo" attribute' do
      Ipizza::Provider.get('sampo').should be_a(Ipizza::Provider::Sampo)
    end

    it 'returns sampo provider for "danske" attribute' do
      Ipizza::Provider.get('danske').should be_a(Ipizza::Provider::Sampo)
    end

    it 'returns krediidipank provider for "krep" attribute' do
      Ipizza::Provider.get('krep').should be_a(Ipizza::Provider::Krediidipank)
    end

    it 'returns krediidipank provider for "krediidipank" attribute' do
      Ipizza::Provider.get('krediidipank').should be_a(Ipizza::Provider::Krediidipank)
    end

    it 'returns nordea provider for "nordea" attribute' do
      Ipizza::Provider.get('nordea').should be_a(Ipizza::Provider::Nordea)
    end

    it 'returns nothing for "unkn" attribute' do
      Ipizza::Provider.get('unkn').should be_nil
    end

    describe '#payment_request' do
      let(:payment) { Ipizza::Payment.new(stamp: 1, amount: '123.34', refnum: 1, message: 'Payment message', currency: 'EUR') }
      before(:each) do
        Ipizza::PaymentRequest.any_instance.stub(:sign)
      end

      it 'should assign return_url from payment' do
        payment.return_url = "new url"
        Ipizza::Provider::Base.new.payment_request(payment).sign_params['VK_RETURN'].should == "new url"
      end

      it 'should assign cancel_url from payment' do
        payment.cancel_url = "new url"
        Ipizza::Provider::Base.new.payment_request(payment).sign_params['VK_CANCEL'].should == "new url"
      end

    end
  end
end
