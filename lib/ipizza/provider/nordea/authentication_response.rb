require 'digest/md5'

module Ipizza::Provider
  class Nordea::AuthenticationResponse < Ipizza::AuthenticationResponse
    
    def initialize(params)
      @params = params
    end

    def verify(key_path)
      key = File.read(key_path).strip
      @valid = @params['B02K_MAC'] == Digest::MD5.hexdigest(mac_data_string(key)).upcase
    end
    
    def success?
      @valid && @params['B02K_CUSTID'].present?
    end
    
    def valid?
      @valid
    end
    
    def info_name
      valid? ? @params['B02K_CUSTNAME'] : ''
    end
    
    def info_social_security_id
      valid? ? @params['B02K_CUSTID'] : ''
    end
    
    private
    
    def mac_data_string(key)
      order = ['VERS', 'TIMESTMP', 'IDNBR', 'STAMP', 'CUSTNAME', 'KEYVERS', 'ALG', 'CUSTID', 'CUSTTYPE']
      
      datastr = order.inject('') do |memo, param|
        memo << @params["B02K_#{param}"].to_s << '&'
      end
      datastr << key << '&'
    end
  end
end