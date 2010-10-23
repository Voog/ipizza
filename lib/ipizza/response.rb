require 'openssl'

class Ipizza::Response

  attr_accessor :provider
  attr_accessor :verify_params
  attr_accessor :verify_params_order
  
  @@response_param_order = {
    '1101' => ['VK_SERVICE', 'VK_VERSION', 'VK_SND_ID', 'VK_REC_ID', 'VK_STAMP', 'VK_T_NO', 'VK_AMOUNT', 'VK_CURR', 'VK_REC_ACC', 'VK_REC_NAME', 'VK_SND_ACC', 'VK_SND_NAME', 'VK_REF', 'VK_MSG', 'VK_T_DATE'],
    '3002' => ['VK_SERVICE', 'VK_VERSION', 'VK_USER', 'VK_DATE', 'VK_TIME', 'VK_SND_ID', 'VK_INFO'],
    '1901' => ['VK_SERVICE', 'VK_VERSION', 'VK_SND_ID', 'VK_REC_ID', 'VK_STAMP', 'VK_REF', 'VK_MSG'],
    '1902' => ['VK_SERVICE', 'VK_VERSION', 'VK_SND_ID', 'VK_REC_ID', 'VK_STAMP', 'VK_REF', 'VK_MSG', 'VK_ERROR_CODE']
  }  
  
  def initialize(params, provider)
    @params = params
    @provider = provider
  end

  def verify(certificate_path, charset = 'UTF-8')
    param_order = @@response_param_order[@params['VK_SERVICE']]
    verify_params = param_order.inject(Hash.new) { |h, p| h[p] = @params[p]; h }
    mac_string = Ipizza::Util.mac_data_string(verify_params, param_order, 'UTF-8', charset)

    certificate = OpenSSL::X509::Certificate.new(File.read(certificate_path).gsub(/  /, '')).public_key
    @valid = certificate.verify(OpenSSL::Digest::SHA1.new, Base64.decode64(@params['VK_MAC']), mac_string)
  end
end