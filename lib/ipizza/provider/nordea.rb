module Ipizza::Provider

  # TODO: configure whether use sha-1 or md5 for signing and verification
  class Nordea

    require 'ipizza/provider/nordea/payment_request'
    require 'ipizza/provider/nordea/payment_response'
    require 'ipizza/provider/nordea/authentication_request'
    require 'ipizza/provider/nordea/authentication_response'

    class << self
      attr_accessor :payments_service_url, :payments_return_url, :payments_reject_url, :payments_cancel_url
      attr_accessor :payments_rcv_id, :payments_language
      attr_accessor :auth_service_url, :auth_return_url, :auth_reject_url, :auth_cancel_url, :auth_language
      attr_accessor :auth_rcv_id
      attr_accessor :file_key, :rcv_account, :rcv_name, :confirm, :keyvers
    end

    def payment_request(payment, service = 1002)
      req = Ipizza::Provider::Nordea::PaymentRequest.new
      req.service_url = self.class.payments_service_url
      req.params = {
        'VERSION' => '0003',
        'STAMP' => payment.stamp,
        'RCV_ID' => self.class.payments_rcv_id,
        # 'RCV_ACCOUNT' => self.rcv_account,
        # 'RCV_NAME' => self.rcv_name,
        'LANGUAGE' => self.class.payments_language,
        'AMOUNT' => sprintf('%.2f', payment.amount),
        'REF' => Ipizza::Util.sign_731(payment.refnum),
        'DATE' => 'EXPRESS',
        'MSG' => payment.message,
        'CONFIRM' => self.class.confirm,
        'CUR' => payment.currency,
        'KEYVERS' => self.class.keyvers,
        'REJECT' => self.class.payments_reject_url,
        'RETURN' => self.class.payments_return_url,
        'CANCEL' => self.class.payments_cancel_url
      }

      req.sign(self.class.file_key)
      req
    end

    def payment_response(params)
      response = Ipizza::Provider::Nordea::PaymentResponse.new(params)
      response.verify(self.class.file_key)
      return response
    end

    def authentication_request
      req = Ipizza::Provider::Nordea::AuthenticationRequest.new
      req.service_url = self.class.auth_service_url
      req.params = {
        'ACTION_ID' => '701',
        'VERS' => '0002',
        'RCVID' => self.class.auth_rcv_id,
        'LANGCODE' => self.class.auth_language,
        'STAMP' => Time.now.strftime('%Y%m%d%H%M%S'),
        'IDTYPE' => '02',
        'KEYVERS' => self.class.keyvers,
        'RETLINK' => self.class.auth_return_url,
        'CANLINK' => self.class.auth_cancel_url,
        'REJLINK' => self.class.auth_reject_url,
        'ALG' => '01'
      }
      req.sign(self.class.file_key)
      req
    end

    def authentication_response(params)
      response = Ipizza::Provider::Nordea::AuthenticationResponse.new(params)
      response.verify(self.class.file_key)
      return response
    end
  end
end
