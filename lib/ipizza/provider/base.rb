module Ipizza::Provider
  class Base

    SUPPORTED_ENCODINGS = %w(UTF-8 ISO-8859-1 WINDOWS-1257)

    class << self
      attr_accessor :service_url, :return_url, :cancel_url, :file_key, :key_secret, :file_cert, :snd_id, :rec_id, :rec_acc, :rec_name, :encoding, :lang
    end

    def payment_request(payment, service_no = 1012)
      req = Ipizza::PaymentRequest.new
      req.service_url = self.class.service_url
      req.sign_params = {
        'VK_SERVICE' => service_no,
        'VK_VERSION' => '008',
        'VK_SND_ID' => self.class.snd_id,
        'VK_STAMP' => payment.stamp,
        'VK_AMOUNT' => sprintf('%.2f', payment.amount),
        'VK_CURR' => payment.currency,
        'VK_REF' => Ipizza::Util.sign_731(payment.refnum),
        'VK_MSG' => payment.message,
        'VK_RETURN' => self.class.return_url,
        'VK_CANCEL' => self.class.cancel_url,
        'VK_DATETIME' => Ipizza::Util.time_to_iso8601(Time.now)
      }

      if service_no.to_s == '1011'
        req.sign_params['VK_ACC'] = self.class.rec_acc
        req.sign_params['VK_NAME'] = self.class.rec_name
      end

      req.extra_params = {
        'VK_ENCODING' => get_encoding(self.class.encoding),
        'VK_LANG' => self.class.lang
      }

      req.sign(self.class.file_key, self.class.key_secret, Ipizza::Request::PARAM_ORDER[service_no.to_s])
      req
    end

    def payment_response(params)
      response = Ipizza::PaymentResponse.new(params)
      response.verify(self.class.file_cert)
      response
    end

    def authentication_request(service_no = 4011, param = {})
      req = Ipizza::AuthenticationRequest.new
      req.service_url = self.class.service_url
      req.sign_params = {
        'VK_SERVICE' => service_no,
        'VK_VERSION' => '008',
        'VK_SND_ID' => self.class.snd_id,
        'VK_RETURN' => self.class.return_url,
        'VK_DATETIME' => Ipizza::Util.time_to_iso8601(Time.now),
        'VK_RID' => param[:vk_rid]
      }

      case service_no.to_s
      when '4011'
        req.sign_params['VK_REPLY'] = '3012'
      when '4012'
        req.sign_params.merge(
          'VK_REC_ID' => self.class.rec_id,
          'VK_NONCE' => param[:vk_nonce]
        )
      end

      req.extra_params = {
        'VK_ENCODING' => get_encoding(self.class.encoding),
        'VK_LANG' => self.class.lang
      }

      req.sign(self.class.file_key, self.class.key_secret, Ipizza::Request::PARAM_ORDER[service_no.to_s])
      req
    end

    def authentication_response(params)
      response = Ipizza::AuthenticationResponse.new(params)
      response.verify(self.class.file_cert)
      response
    end

    private

    def get_encoding(val)
      SUPPORTED_ENCODINGS.include?(val.to_s.upcase) ? val.to_s.upcase : 'UTF-8'
    end
  end
end
