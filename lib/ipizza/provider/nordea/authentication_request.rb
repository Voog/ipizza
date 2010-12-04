require 'digest/md5'

module Ipizza::Provider
  class Nordea::AuthenticationRequest < Ipizza::AuthenticationRequest
    
    attr_accessor :params
    attr_accessor :service_url

    def sign(key_path)
      key = File.read(key_path).strip
      params['MAC'] = Digest::MD5.hexdigest(mac_data_string(key)).upcase
    end
    
    def request_params
      params.inject(Hash.new) { |h, v| h["A01Y_#{v.first}"] = v.last; h }
    end
    
    private
    
    def mac_data_string(key)
      order = ['ACTION_ID', 'VERS', 'RCVID', 'LANGCODE', 'STAMP', 'IDTYPE', 'RETLINK', 'CANLINK', 'REJLINK', 'KEYVERS', 'ALG']
      
      datastr = order.inject('') do |memo, param|
        memo << params[param].to_s << '&'
      end
      datastr << key << '&'
    end
  end
end