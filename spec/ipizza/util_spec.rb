require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Ipizza::Util do
  describe 'sign' do
  end

  describe '.verify_signature' do
  end
  
  describe '.sign_731' do
    it 'should add control number to the end of input string' do
      Ipizza::Util.sign_731('12').should == '123'
    end
  end
  
  describe '.mac_data_string' do
    it 'should compose mac string containing the values and their respective lengths' do
      Ipizza::Util.mac_data_string({'A' => 'aaa', 'B' => 'bbbb'}, ['B', 'A']).should == '004bbbb003aaa'
    end
  end
end
