require 'openssl'
require 'base64'

module Ipizza
  class Request
    
    attr_accessor :extra_params
    attr_accessor :sign_params
    attr_accessor :service_url
    
    def sign(privkey_path, privkey_secret, order, mac_param = 'VK_MAC')
      privkey = File.open(privkey_path, 'r') { |f| f.read }
      
      privkey = OpenSSL::PKey::RSA.new(privkey.gsub(/  /, ''), privkey_secret)
      
      signature = privkey.sign(OpenSSL::Digest::SHA1.new, Ipizza::Util.mac_data_string(sign_params, order))
      signature = Base64.encode64(signature).gsub(/\n/, '')
      
      self.sign_params[mac_param] = signature
    end
    
    def request_params
      sign_params.merge(extra_params)
    end
  end
end