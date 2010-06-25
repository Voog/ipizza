module Pizza::Provider
  
  # TODO: configure whether use sha-1 or md5 for signing and verification
  class Nordea
    
    cattr_accessor :service_url, :return_url, :reject_url, :cancel_url, :key, :rcv_id, :rcv_account, :rcv_name, :language, :confirm, :keyvers
    
    def payment_request(payment, service = 1002)
      req = Pizza::Provider::Nordea::PaymentRequest.new
      req.service_url = self.service_url
      req.params = {
        'VERSION' => '0003',
        'STAMP' => payment.stamp,
        'RCV_ID' => self.rcv_id,
        # 'RCV_ACCOUNT' => self.rcv_account,
        # 'RCV_NAME' => self.rcv_name,
        'LANGUAGE' => self.language,
        'AMOUNT' => sprintf('%.2f', payment.amount),
        'REF' => Pizza::Util.sign_731(payment.refnum),
        'DATE' => 'EXPRESS',
        'MSG' => payment.message,
        'CONFIRM' => self.confirm,
        'CUR' => payment.currency,
        'KEYVERS' => self.keyvers,
        'REJECT' => self.reject_url,
        'RETURN' => self.return_url,
        'CANCEL' => self.cancel_url
      }
      
      req.sign(self.key)
      req
    end
    
    def payment_response(params)
      response = Pizza::Provider::Nordea::PaymentResponse.new(params)
      response.provider = Pizza::Util::NORDEA
      response.verify(self.key)
      
      return response
    end
  end
end
