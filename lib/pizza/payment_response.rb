module Pizza
  class PaymentResponse
    
    attr_accessor :provider
    attr_accessor :verify_params
    attr_accessor :verify_params_order
    
    @@response_param_order = {
      '1101' => ['VK_SERVICE', 'VK_VERSION', 'VK_SND_ID', 'VK_REC_ID', 'VK_STAMP', 'VK_T_NO', 'VK_AMOUNT', 'VK_CURR', 'VK_REC_ACC', 'VK_REC_NAME', 'VK_SND_ACC', 'VK_SND_NAME', 'VK_REF', 'VK_MSG', 'VK_T_DATE'],
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
      
      certificate = OpenSSL::X509::Certificate.new(File.read(certificate_path).gsub(/  /, '')).public_key
      mac_string = Pizza::Util.mac_data_string(verify_params, param_order, 'UTF-8', charset)
      
      @valid = certificate.verify(OpenSSL::Digest::SHA1.new, Base64.decode64(@params['VK_MAC']), mac_string)
    end
    
    def success?
      return ['1101'].include?(@params['VK_SERVICE'])
    end
    
    def valid?
      return @valid
    end
    
    def automatic_message?
      @params['VK_AUTO'] and @params['VK_AUTO'] == 'Y'
    end
    
    def payment_info
      @payment_info ||= Pizza::Payment.new(
        :stamp => @params['VK_STAMP'], :amount => @params['VK_AMOUNT'], :currency => @params['VK_CURR'],
        :refnum => @params['VK_REF'], :message => @params['VK_MSG'], :transaction_id => @params['VK_T_NO'],
        :receiver_account => @params['VK_REC_ACC'], :receiver_name => @params['VK_REC_NAME'],
        :sender_account => @params['VK_SND_ACC'], :sender_name => @params['VK_SND_NAME']
      )
    end
  end
end