require 'digest/md5'

module Pizza::Provider
  class Nordea::PaymentResponse < Pizza::PaymentResponse
    
    def initialize(params)
      @params = params
    end
    
    def verify(key_path)
      key = File.read(key_path)
      @valid = @params['RETURN_MAC'] == Digest::MD5.hexdigest(mac_data_string(key)).upcase
    end
    
    def success?
      if @valid && !@params['RETURN_PAID'].blank? then true else false end
    end
    
    def valid?
      @valid
    end
    
    def payment_info
      @payment_info ||= Pizza::Payment.new(:stamp => @params['RETURN_STAMP'], :refnum => @params['RETURN_REF'])
    end
    
    private
    
    def mac_data_string(key)
      order = ['RETURN_VERSION', 'RETURN_STAMP', 'RETURN_REF', 'RETURN_PAID']
      
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