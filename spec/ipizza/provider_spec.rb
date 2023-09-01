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
end
