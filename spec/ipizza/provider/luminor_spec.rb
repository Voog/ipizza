require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Ipizza::Provider::Luminor do
  let(:response_time) { Ipizza::Util.time_to_iso8601(Time.now) }
  let(:bank_key) { File.expand_path('../../../certificates/pangalink_luminor_bank_key.pem', __FILE__) }

  describe '#payment_request' do
    let(:payment) { Ipizza::Payment.new(stamp: 1, amount: '123.34', refnum: 1, message: 'Payment message', currency: 'EUR') }

    before(:each) do
      req_time = Time.now
      Time.stub!(:now).and_return(req_time)
    end

    it 'should sign the request' do
      req = Ipizza::Provider::Luminor.new.payment_request(payment)
      params = {
        'VK_SERVICE' => '1012',
        'VK_VERSION' => '008',
        'VK_SND_ID' => Ipizza::Provider::Luminor.snd_id,
        'VK_STAMP' => payment.stamp,
        'VK_AMOUNT' => sprintf('%.2f', payment.amount),
        'VK_CURR' => payment.currency,
        'VK_REF' => Ipizza::Util.sign_731(payment.refnum),
        'VK_MSG' => payment.message,
        'VK_RETURN' => Ipizza::Provider::Luminor.return_url,
        'VK_CANCEL' => Ipizza::Provider::Luminor.cancel_url,
        'VK_DATETIME' => Ipizza::Util.time_to_iso8601(Time.now)
      }
      signature = Ipizza::Util.sign(Ipizza::Provider::Luminor.file_key, Ipizza::Provider::Luminor.key_secret, Ipizza::Util.mac_data_string(params, Ipizza::Request::PARAM_ORDER['1012']))
      req.sign_params['VK_MAC'].should == signature
    end
  end

  describe '#payment_response' do
    let(:params) {
      {
        'VK_SERVICE' => '1111', 'VK_VERSION' => '008', 'VK_SND_ID' => 'LUMINOR', 'VK_REC_ID' => 'sender',
        'VK_STAMP' => '20150111000004', 'VK_T_NO' => '1143', 'VK_AMOUNT' => '.17', 'VK_CURR' => 'EUR',
        'VK_REC_ACC' => 'EE411010002050618003', 'VK_REC_NAME' => 'ÕILIS OÜ',
        'VK_SND_ACC' => 'EE541010010046155012', 'VK_SND_NAME' => 'TÕÄGER Leõpäöld¸´¨¦',
        'VK_REF' => '201501110000048', 'VK_MSG' => 'Invoice #20150111000004', 'VK_T_DATETIME' => response_time,
        'VK_ENCODING' => 'UTF-8', 'VK_LANG' => 'EST', 'VK_AUTO' => 'N'
      }
    }

    it 'should parse and verify the payment response from bank' do
      signature = Ipizza::Util.sign(bank_key, nil, Ipizza::Util.mac_data_string(params, Ipizza::Response::PARAM_ORDER['1111']))
      Ipizza::Provider::Luminor.new.payment_response(params.merge('VK_MAC' => signature)).should be_valid
    end
  end

  describe '#authentication_request' do
    before(:each) do
      req_time = Time.now
      Time.stub!(:now).and_return(req_time)
    end

    it 'should sign the request' do
      req = Ipizza::Provider::Luminor.new.authentication_request
      params = {
        'VK_SERVICE' => '4011',
        'VK_VERSION' => '008',
        'VK_SND_ID' => Ipizza::Provider::Luminor.snd_id,
        'VK_RETURN' => Ipizza::Provider::Luminor.return_url,
        'VK_DATETIME' => Ipizza::Util.time_to_iso8601(Time.now),
        'VK_RID' => '',
        'VK_REPLY' => '3012'
      }
      signature = Ipizza::Util.sign(Ipizza::Provider::Luminor.file_key, Ipizza::Provider::Luminor.key_secret, Ipizza::Util.mac_data_string(params, Ipizza::Request::PARAM_ORDER['4011']))
      req.sign_params['VK_MAC'].should == signature
    end
  end

  describe '#authentication_response' do
    let(:params) {
      {
        'VK_SERVICE' => '3012', 'VK_VERSION' => '008', 'VK_USER' => 'dealer', 'VK_DATETIME' => response_time,
        'VK_SND_ID' => 'LUMINOR', 'VK_REC_ID' => 'sender', 'VK_USER_NAME' => 'TÕÄGER Leõpäöld¸´¨¦', 'VK_USER_ID' => '35511280268',
        'VK_COUNTRY' => 'EE', 'VK_OTHER' => '', 'VK_TOKEN' => '7', 'VK_RID' => ''
      }
    }

    it 'should parse and verify the authentication response from bank' do
      signature = Ipizza::Util.sign(bank_key, nil, Ipizza::Util.mac_data_string(params, Ipizza::Response::PARAM_ORDER['3012']))
      Ipizza::Provider::Luminor.new.authentication_response(params.merge('VK_MAC' => signature)).should be_valid
    end
  end
end
