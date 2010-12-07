module Ipizza::Provider
  class Seb
    
    class << self
      attr_accessor :service_url, :return_url, :cancel_url, :file_key, :key_secret, :file_cert, :snd_id, :encoding, :rec_acc, :rec_name
    end
    
    def payment_request(payment, service = 1002)
      req = Ipizza::PaymentRequest.new
      req.service_url = self.class.service_url
      req.sign_params = {
        'VK_SERVICE' => service.to_s,
        'VK_VERSION' => '008',
        'VK_SND_ID' => self.class.snd_id,
        'VK_STAMP' => payment.stamp,
        'VK_AMOUNT' => sprintf('%.2f', payment.amount),
        'VK_CURR' => payment.currency,
        'VK_REF' => Ipizza::Util.sign_731(payment.refnum),
        'VK_MSG' => payment.message
      }

      # TODO: add 1001 support
      # if service == 1001
      #   req.sign_params['VK_ACC'] = self.rec_acc
      #   req.sign_params['VK_NAME'] = self.rec_name
      # end
      
      req.extra_params = {
        'VK_CHARSET' => self.class.encoding,
        'VK_RETURN' => self.class.return_url,
        'VK_CANCEL' => self.class.cancel_url
      }
      
      if service == 1001
        param_order = ['VK_SERVICE', 'VK_VERSION', 'VK_SND_ID', 'VK_STAMP', 'VK_AMOUNT', 'VK_CURR', 'VK_ACC', 'VK_NAME', 'VK_REF', 'VK_MSG']
      else
        param_order = ['VK_SERVICE', 'VK_VERSION', 'VK_SND_ID', 'VK_STAMP', 'VK_AMOUNT', 'VK_CURR', 'VK_REF', 'VK_MSG']
      end

      req.sign(self.class.file_key, self.class.key_secret, param_order)
      req
    end
    
    def payment_response(params)
      response = Ipizza::PaymentResponse.new(params)
      response.verify(self.class.file_cert)
      
      return response
    end

    def authentication_request(service_no = 4001)
      req = Ipizza::AuthenticationRequest.new
      req.service_url = self.class.service_url
      req.sign_params = {
        'VK_SERVICE' => service_no,
        'VK_VERSION' => '008',
        'VK_SND_ID' => self.class.snd_id,
        'VK_REPLY' => '3002',
        'VK_RETURN' => self.class.return_url,
        'VK_DATE' => Date.today.strftime('%d.%m.%Y'),
        'VK_TIME' => Time.now.strftime('%H:%M:%S')
      }
    
      req.extra_params = {
        'VK_CHARSET' => self.class.encoding
      }
    
      param_order = ['VK_SERVICE', 'VK_VERSION', 'VK_SND_ID', 'VK_REPLY', 'VK_RETURN', 'VK_DATE', 'VK_TIME']
    
      req.sign(self.class.file_key, self.class.key_secret, param_order)
      req
    end
    
    def authentication_response(params)
      response = Ipizza::AuthenticationResponse.new(params)
      response.verify(self.class.file_cert)
      return response
    end

  end
end
