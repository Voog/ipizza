class Ipizza::Response

  attr_accessor :verify_params
  attr_accessor :verify_params_order
  
  PARAM_ORDER = {
    '1111' => %w(VK_SERVICE VK_VERSION VK_SND_ID VK_REC_ID VK_STAMP VK_T_NO VK_AMOUNT VK_CURR VK_REC_ACC VK_REC_NAME VK_SND_ACC VK_SND_NAME VK_REF VK_MSG VK_T_DATETIME),
    '3012' => %w(VK_SERVICE VK_VERSION VK_USER VK_DATETIME VK_SND_ID VK_REC_ID VK_USER_NAME VK_USER_ID VK_COUNTRY VK_OTHER VK_TOKEN VK_RID),
    '3013' => %w(VK_SERVICE VK_VERSION VK_DATETIME VK_SND_ID VK_REC_ID VK_NONCE VK_USER_NAME VK_USER_ID VK_COUNTRY VK_OTHER VK_TOKEN VK_RID),
    '1911' => %w(VK_SERVICE VK_VERSION VK_SND_ID VK_REC_ID VK_STAMP VK_REF VK_MSG)
  }  
  
  def initialize(params)
    @params = params
  end

  def verify(certificate_path)
    mac_string = Ipizza::Util.mac_data_string(@params, PARAM_ORDER[@params['VK_SERVICE']])

    @valid = Ipizza::Util.verify_signature(certificate_path, @params['VK_MAC'], mac_string)
  end
end
