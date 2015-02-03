module Ipizza
  class Request
    
    attr_accessor :extra_params
    attr_accessor :sign_params
    attr_accessor :service_url

    PARAM_ORDER = {
      '1011' => %w(VK_SERVICE VK_VERSION VK_SND_ID VK_STAMP VK_AMOUNT VK_CURR VK_ACC VK_NAME VK_REF VK_MSG VK_RETURN VK_CANCEL VK_DATETIME),
      '1012' => %w(VK_SERVICE VK_VERSION VK_SND_ID VK_STAMP VK_AMOUNT VK_CURR VK_REF VK_MSG VK_RETURN VK_CANCEL VK_DATETIME),
      '4011' => %w(VK_SERVICE VK_VERSION VK_SND_ID VK_REPLY VK_RETURN VK_DATETIME VK_RID),
      '4012' => %w(VK_SERVICE VK_VERSION VK_SND_ID VK_REC_ID VK_NONCE VK_RETURN VK_DATETIME VK_RID)
    }

    def sign(privkey_path, privkey_secret, order, mac_param = 'VK_MAC')
      signature = Ipizza::Util.sign(privkey_path, privkey_secret, Ipizza::Util.mac_data_string(sign_params, order))
      self.sign_params[mac_param] = signature
    end
    
    def request_params
      sign_params.merge(extra_params)
    end
  end
end
