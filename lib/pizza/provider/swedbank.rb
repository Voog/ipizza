module Pizza::Provider
  class Swedbank
    
    class << self
      attr_accessor :service_url, :return_url, :cancel_url, :key, :key_secret, :cert, :snd_id, :encoding
    end
    
    def payment_request(payment, service = 1002)
      req = Pizza::PaymentRequest.new
      req.service_url = self.class.service_url
      req.sign_params = {
        'VK_SERVICE' => '1002',
        'VK_VERSION' => '008',
        'VK_SND_ID' => self.class.snd_id,
        'VK_STAMP' => payment.stamp,
        'VK_AMOUNT' => sprintf('%.2f', payment.amount),
        'VK_CURR' => payment.currency,
        'VK_REF' => Pizza::Util.sign_731(payment.refnum),
        'VK_MSG' => payment.message
      }
      
      req.extra_params = {
        'VK_CHARSET' => self.class.encoding,
        'VK_RETURN' => self.class.return_url,
        'VK_CANCEL' => self.class.cancel_url
      }
      
      param_order = ['VK_SERVICE', 'VK_VERSION', 'VK_SND_ID', 'VK_STAMP', 'VK_AMOUNT', 'VK_CURR', 'VK_REF', 'VK_MSG']
      
      req.sign(self.class.key, self.class.key_secret, param_order)
      req
    end
    
    def payment_response(params)
      response = Pizza::PaymentResponse.new(params, Pizza::Util::SWEDBANK)
      response.verify(cert, 'ISO-8859-4')
      
      return response
    end
  end
end
