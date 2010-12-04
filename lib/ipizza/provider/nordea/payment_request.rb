require 'digest/md5'

module Ipizza::Provider
  class Nordea::PaymentRequest < Ipizza::PaymentRequest
    
    attr_accessor :params
    attr_accessor :service_url
    
    def sign(key_path)
      key = File.read(key_path).strip
      self.params['MAC'] = Digest::MD5.hexdigest(mac_data_string(key)).upcase
    end
    
    def request_params
      params
    end
    
    private
    
    def mac_data_string(key)
      order = ['VERSION', 'STAMP', 'RCV_ID', 'AMOUNT', 'REF', 'DATE', 'CUR']
      
      datastr = order.inject('') do |memo, param|
        memo << params[param].to_s
        memo << '&'
        memo
      end
      datastr << key
      datastr << '&'
      datastr
    end
  end
end