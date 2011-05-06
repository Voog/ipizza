require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Ipizza::Provider do
  describe '.get' do
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

    it 'returns sampo provider for "sampo" attribute' do
      Ipizza::Provider.get('sampo').should be_a(Ipizza::Provider::Sampo)
    end
    it 'returns nordea provider for "nordea" attribute' do
      Ipizza::Provider.get('nordea').should be_a(Ipizza::Provider::Nordea)
    end
  end
end
