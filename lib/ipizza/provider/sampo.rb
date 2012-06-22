module Ipizza::Provider
  class Sampo

    class << self
      attr_accessor :service_url, :return_url, :file_key, :key_secret, :file_cert, :snd_id, :lang, :rec_acc, :rec_name
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

      if service == 1001
        req.sign_params['VK_ACC'] = self.class.rec_acc
        req.sign_params['VK_NAME'] = self.class.rec_name
      end

      req.extra_params = {
        'VK_RETURN' => self.class.return_url,
        'VK_LANG' => self.class.lang
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
  end
end
