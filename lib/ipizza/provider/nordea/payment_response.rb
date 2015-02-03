require 'digest/md5'

module Ipizza::Provider
  class Nordea::PaymentResponse < Ipizza::PaymentResponse
    
    def initialize(params)
      @params = params
    end
    
    def verify(key_path)
      key = File.read(key_path)
      @valid = @params['RETURN_MAC'] == Digest::MD5.hexdigest(mac_data_string(key)).upcase
    end
    
    def success?
      @valid && !@params['RETURN_PAID'].blank?
    end
    
    def valid?
      @valid
    end
    
    def payment_info
      @payment_info ||= Ipizza::Payment.new(stamp: @params['RETURN_STAMP'], refnum: @params['RETURN_REF'])
    end
    
    private
    
    def mac_data_string(key)
      order = %w(RETURN_VERSION RETURN_STAMP RETURN_REF RETURN_PAID)
      
      datastr = order.inject('') do |memo, param|
        memo << @params[param].to_s
        memo << '&'
        memo
      end
      datastr << key
      datastr << '&'
      
      datastr
    end
  end
end
