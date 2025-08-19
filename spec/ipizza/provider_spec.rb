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

    it 'returns nothing for "unkn" attribute' do
      Ipizza::Provider.get('unkn').should be_nil
    end
  end

  describe 'VK_VERSION override' do
    let(:payment) do
      Ipizza::Payment.new(stamp: 1, amount: '1.00', refnum: 1, message: 'Msg', currency: 'EUR')
    end

    before do
      # Reset any custom value potentially set by other specs
      Ipizza::Provider::Swedbank.vk_version = nil
    end

    it 'defaults to 008 when not set' do
      req = Ipizza::Provider::Swedbank.new.payment_request(payment)
      req.sign_params['VK_VERSION'].should == '008'
    end

    it 'uses overridden static value' do
      Ipizza::Provider::Swedbank.vk_version = '009'
      req = Ipizza::Provider::Swedbank.new.payment_request(payment)
      req.sign_params['VK_VERSION'].should == '009'
    end

    it 'falls back when blank string provided' do
      Ipizza::Provider::Swedbank.vk_version = '  '
      req = Ipizza::Provider::Swedbank.new.authentication_request
      req.sign_params['VK_VERSION'].should == '008'
    end
  end
end
